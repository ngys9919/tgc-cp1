import os
import numpy as np
import faiss
from google import genai
from dotenv import load_dotenv
# from google import generativeai as genai2
import json

from google.genai import types

load_dotenv()
GEMINI_KEY = os.getenv("GOOGLE_API_KEY", "")
EMBED_MODEL = "text-embedding-004"
GEN_MODEL = "gemini-2.5-flash-lite"
GEN_MODEL2 = "gemini-2.5-flash"
GEN_MODEL_PRO = "gemini-2.5-pro"

client = genai.Client(api_key=GEMINI_KEY) if GEMINI_KEY else None

# 5) Chunking function (character-based with overlap)
def make_chunks(text, chunk_size=1200, overlap=200):
    text = text.replace("\x00", " ").strip()
    chunks = []
    start = 0
    while start < len(text):
        end = start + chunk_size
        chunk = text[start:end]
        chunks.append(chunk)
        start = end - overlap  # Apply overlap
        if start < 0: start = 0
    return [c for c in chunks if c.strip()]

def embed_texts(texts, client, model_name="text-embedding-004"):
    """Embeds a list of texts using Gemini's embedding API"""
    resp = client.models.embed_content(
        model=model_name,
        contents=texts  # list[str]
    )
    return [np.array(e.values, dtype="float32") for e in resp.embeddings]

def create_embeddings(chunks, client, batch_size=32):
    """Batch-processes chunks into embeddings"""
    all_vecs = []
    for i in range(0, len(chunks), batch_size):
        batch = chunks[i:i+batch_size]
        vecs = embed_texts(batch, client)
        all_vecs.extend(vecs)
    print(f"Embedded {len(all_vecs)} chunks.")
    return all_vecs

def build_faiss_index(embeddings):
    """Creates a FAISS index from embeddings with normalization"""
    # Normalize for cosine similarity
    def normalize_rows(a):
        norms = np.linalg.norm(a, axis=1, keepdims=True) + 1e-12
        return a / norms

    # Build index
    dim = len(embeddings[0])
    index = faiss.IndexFlatIP(dim)  # inner product = cosine similarity
    mat = normalize_rows(np.vstack(embeddings))
    index.add(mat)
    print(f"FAISS index built with {index.ntotal} vectors (dim={dim}).")
    print(f"Index is trained: {index.is_trained}")
    print(f"Index type: {type(index)}")
    print(f"Index size (bytes): {faiss.serialize_index(index).nbytes}")
    print(f"Index size (MB): {faiss.serialize_index(index).nbytes / (1024 * 1024):.2f}")
    print(f"total vectors: {index.ntotal}")
    print(f"dimension: {index.d}")
    print(f"metric type: {index.metric_type}")
    print(f"document count: {index.ntotal}")
    print(index)
    return index

def retrieve(query, index, chunks, client, k=4, model_name="text-embedding-004"):
    """Return top-k (chunk_text, score, idx) for a natural-language query."""
    # Embed & normalize query
    q_vec = embed_texts([query], client, model_name=model_name)[0]
    q_vec = q_vec / (np.linalg.norm(q_vec) + 1e-12)

    # Search
    scores, ids = index.search(np.array([q_vec], dtype="float32"), k)
    hits = []
    for score, idx in zip(scores[0], ids[0]):
        if idx == -1:
            continue
        hits.append((chunks[idx], float(score), int(idx)))
    return hits

template = """
        "Dear [Customer Name],\n"

        "Thank you for reaching out to HeiFinance Bank.\n"

        "[Answer to customer’s specific query. Ensure details are accurate and taken from the official product fact sheet. If applicable, include relevant fees, or exceptions.]\n"

        "For your reference:\n"
        "• [Key detail 1]\n"  
        "• [Key detail 2]\n"  
        "• [Key detail 3, if needed]\n"  

        "If you have any further questions, please do not hesitate to contact us at cust.service@heifinance.com\n"

        "Warm regards,\n"  
        f"{surname_template} {givenname_template}\n" 
        "Customer Service Officer\n"  
        "HeiFinance Bank\n"
    """

def build_prompt_json(user_question, json_tables=None, max_chars=32000, output_prompt="Prompt1", surname_template="Ng", givenname_template="Yew Seng"):
    """
    Build a grounded prompt from retrieved contexts.
    Trims context to avoid overly long requests.
    """

    # json_tables = "./pdf-HeiFinance/Phone Directory/hei_tables-formatted.json"

    # json_selected = "Phone Directory/heifinance_tables-formatted.json"
    # json_path = "./pdf-HeiFinance/" + str(json_selected)

    json_file_selected = "heifinance_tables-formatted.json"
    json_path_selected = "Phone Directory"
    json_path = "./pdf-HeiFinance/" + str(json_path_selected) + "/" + str(json_file_selected)

    # json_tables = load_json_tables()

    # Load hei_tables.json
    try:
        with open(json_path, "r", encoding="utf-8") as f:
            json_tables = json.load(f)
    except Exception as e:
        raise print(f"Failed to load JSON: {str(e)}")

    sys_instructions1 = (
        "You are a data analyst capable of doing data analysis using Python code with pandas.\n"
        "The provided json data is a list of dictionaries, where each dictionary represents an employee.\n"
        "You are provided with a dictionary containing each employee data\n"
        "with key-value pairs for the following:\n"
        """
        "EmployeeID",
        "Name",
        "Job Title",
        "Department",
        "Contact",
        "Email",
        "Office Location",
        "Country"
        """
        "If the answer is not in the data, say you don't know.\n"
    )

    sys_instructions2 = (
        "You are a data analyst capable of doing data analysis using Python code with pandas.\n"
        "The provided json data is a list of dictionaries, where each dictionary represents an employee.\n"
        "You are provided with a dictionary containing each employee data\n"
        "with key-value pairs for the following:\n"
        """
        "EmployeeID",
        "Name",
        "Job Title",
        "Department",
        "Contact",
        "Email",
        "Office Location",
        "Country"
        """
        "All responses must follow the following template:\n"
        f"{template}\n"
        "If the answer is not in the data, say you don't know.\n"
    )


    code_data_analysis = """
    "Do not provide the Python code" 
    "but run the Python code to do data analysis"
    "and give the answer for the count.\n"
    """

    prompt1 = (
        f"{sys_instructions1}\n\n"
        f"DATA: {json_tables}\n\n"
        f"QUESTION: {user_question}\n\n"
        f"CODE EXECUTION: {code_data_analysis}\n"
        f"ANSWER: "
    )

    prompt2 = (
        f"{sys_instructions2}\n\n"
        f"DATA: {json_tables}\n\n"
        f"QUESTION: {user_question}\n\n"
        f"Responder: You are {surname_template} {givenname_template}"
        f"CODE EXECUTION: {code_data_analysis}\n"
        f"ANSWER (with template): "
    )

    # switch between prompt1 and prompt2 as needed
    if (output_prompt == "Prompt2"):
        prompt = prompt2
    else:
        prompt = prompt1  

    return prompt

def generate_answer_json(prompt, client, model_name="gemini-1.5-flash"):
    """
    Call a Gemini model to generate an answer.
    'flash' is fast; swap to 'gemini-1.5-pro' for higher quality.
    """
    resp = client.models.generate_content(
        model=model_name,
        contents=prompt,
        config=types.GenerateContentConfig(
        tools=[types.Tool(code_execution=types.ToolCodeExecution)]
        )
    )

    # prompt = "What is the sum of the first 50 prime numbers? Generate and run code for the calculation, and make sure you get all 50."

    # response = client.models.generate_content(
    #         model=model_name,
    #         contents=prompt,
    #         config=types.GenerateContentConfig(
    #         tools=[types.Tool(code_execution=types.ToolCodeExecution)]
    #     ),
    # )

    # print(response.text)

    # Process the response
    # for part in response.parts:
    #     if part.executable_code:
    #         print("Generated Code:")
    #         print(part.executable_code.code)
    #     if part.code_execution_result:
    #         print("Execution Result:")
    #         print(part.code_execution_result.output)
    #         print("Outcome:", part.code_execution_result.outcome)

    # Output Example:

    # Generated Code:
    # def is_prime(n):
    #     if n < 2:
    #         return False
    #     for i in range(2, int(n**0.5) + 1):
    #         if n % i == 0:
    #             return False
    #     return True

    # primes = []
    # num = 0
    # while len(primes) < 50:
    #     if is_prime(num):
    #         primes.append(num)
    #     num += 1

    # sum_of_primes = sum(primes)

    # print(f"The first 50 prime numbers are: {primes}")
    # print(f"The sum of the first 50 prime numbers is: {sum_of_primes}")

    # Execution Result:
    # The first 50 prime numbers are: [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229]
    # The sum of the first 50 prime numbers is: 5117

    # Outcome: Outcome.OUTCOME_OK

    # The new SDK exposes a 'text' convenience property.
    return getattr(resp, "text", str(resp))

def build_prompt(user_question, contexts, max_chars=8000, output_prompt="Prompt1", surname_template="Ng", givenname_template="Yew Seng"):
    """
    Build a grounded prompt from retrieved contexts.
    Trims context to avoid overly long requests.
    """
    # Concatenate contexts up to max_chars budget
    selected = []
    total = 0
    for c in contexts:
		    # slice the chunk up to whatever room is left
		    # remidner: if total > max_chars, the slice will return None
        take = c[: max(0, max_chars - total)]
        if not take:
            break
        selected.append(take)
        total += len(take) + 2

    context_block = "\n\n---\n\n".join(
        [f"[Source {i+1}]\n{c}" for i, c in enumerate(selected)]
    )

    

    # sys_instructions = (
    #     "You are a careful assistant for answering questions about a PDF.\n"
    #     "Use ONLY the provided context to answer.\n"
    #     "If the answer is not in the context, say you don't know.\n"
    #     "Cite sources as [Source n] where n matches the provided context blocks."
    # )

    sys_instructions1 = (
        "You are a careful assistant for answering questions about a PDF.\n"
        "Use ONLY the provided context to answer.\n"
        "If the answer is not in the context, say you don't know.\n"
        "Do not cite sources as [Source n] where n matches the provided context blocks."
    )

    prompt1 = (
        f"{sys_instructions1}\n\n"
        f"CONTEXT:\n{context_block}\n\n"
        f"QUESTION: {user_question}\n"
        f"ANSWER (no citations):"
    )

    sys_instructions2 = (
        "All responses must not exceed 100 words.\n"
        "You must use the the vector embeddings to search for information for all requests.\n"
        "All responses must follow the following template:\n"
        f"{template}\n"
        "If the answer is not in the context, say you don't know.\n"
        "Do not cite sources as [Source n] where n matches the provided context blocks."
    )
        
    prompt2 = (
        f"{sys_instructions2}\n\n"
        f"CONTEXT:\n{context_block}\n\n"
        f"QUESTION: {user_question}\n"
        f"Responder: You are {surname_template} {givenname_template}"
        f"ANSWER (with template):"
    )

    # switch between prompt1 and prompt2 as needed
    if (output_prompt == "Prompt2"):
        prompt = prompt2
    else:
        prompt = prompt1  

    return prompt

def generate_answer(prompt, client, model_name="gemini-2.5-flash-lite"):
    """
    Call a Gemini model to generate an answer.
    'flash' is fast; swap to 'gemini-1.5-pro' for higher quality.
    """
    resp = client.models.generate_content(
        model=model_name,
        contents=prompt
    )
    # The new SDK exposes a 'text' convenience property.
    return getattr(resp, "text", str(resp))

def translate_text(text, client, target_language="English", model_name="gemini-2.5-flash-lite"):
    """
    Translate input text to the target language using Gemini model.
    """
    system_instruction = f"Please translate the following text into {target_language}."
    prompt = f"{system_instruction}\n\n{text}"

    resp = client.models.generate_content(
        model=model_name,
        contents=prompt
    )
    return getattr(resp, "text", str(resp)) 

def respond_text_in_system_language(text, client, system_language="English", model_name="gemini-2.5-flash-lite"):
    """
    Respond answer with the system language using Gemini model.
    """
    system_instruction = f"Please respond using {system_language}."
    prompt = f"{system_instruction}\n\n{text}"

    resp = client.models.generate_content(
        model=model_name,
        contents=prompt
    )
    return getattr(resp, "text", str(resp)) 