import os
import numpy as np
import faiss
from google import genai
from dotenv import load_dotenv
# from google import generativeai as genai2

load_dotenv()
GEMINI_KEY = os.getenv("GOOGLE_API_KEY", "")
EMBED_MODEL = "text-embedding-004"
GEN_MODEL = "gemini-2.5-flash-lite"

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

def build_prompt(user_question, contexts, max_chars=8000):
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

    sys_instructions = (
        "You are a careful assistant for answering questions about a PDF.\n"
        "Use ONLY the provided context to answer.\n"
        "If the answer is not in the context, say you don't know.\n"
        "Do not cite sources as [Source n] where n matches the provided context blocks."
    )

    prompt = (
        f"{sys_instructions}\n\n"
        f"CONTEXT:\n{context_block}\n\n"
        f"QUESTION: {user_question}\n"
        f"ANSWER (with citations):"
    )

    # prompt = (
    #     f"{sys_instructions}\n\n"
    #     f"CONTEXT:\n{context_block}\n\n"
    #     f"QUESTION: {user_question}\n"
    #     f"ANSWER (no citations):"
    # )

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