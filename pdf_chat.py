import gradio as gr
from pypdf import PdfReader
from gemini_utils_pdf import client, respond_text_in_system_language, translate_text, make_chunks, create_embeddings, build_faiss_index, retrieve, build_prompt, generate_answer, EMBED_MODEL, GEN_MODEL
# --- UI helpers and Gradio logic ---


language_look_up1 = {
    1: ("English", "English"),
    2: ("中文", "Chinese")
}

language_selected = "English"
display_language = "English"

def process(language_choice):
    global language_selected
    if language_choice not in language_look_up1:
        language_choice = 1  # Default to English if invalid choice
        language_selected = "English"
        display_language = "English"
        return f"""
        # No Chat Language Selected! 
        ## Defaulted to: <span style='color: blue;'>{ display_language }</span>
        """
    language_selected = language_look_up1.get(language_choice)[1]
    display_language = language_look_up1.get(language_choice)[0]
    return f"""
    # Current Chat Language Selected: <span style='color: blue;'>{ display_language }</span>
    """

pdf_lookup2 = {
    "Annual Report": ("Annual Report", "HeiFinance_Annual_Report_2025.pdf"),
    "Bank Products": ("Bank Products", "HeiFinance Bank Product Fact Sheet.pdf"),
    "Employee Handbook": ("Employee Handbook", "HeiFinance_Employee_Handbook.pdf"),
    "Organisation Chart": ("Organisation Chart", "HeiFinance_Organization_Chart.pdf"),
    "Phone Directory": ("Phone Directory", "HeiFinance_Full_Directory_Complete.pdf")
}

pdf_folder = "Bank Products"
pdf_file = "HeiFinance Bank Product Fact Sheet.pdf"
pdf_selected = pdf_folder + "/" + pdf_file

def update_pdf(new_pdf):
    global pdf_selected
    global pdf_folder
    global pdf_file

    # to refer to the gobal variabl enamed odel
    pdf_prompt = pdf_lookup2.get(new_pdf)
    pdf_folder = pdf_prompt[0]
    pdf_file = pdf_prompt[1]

    # in case the user selects an invalid value (the new_pdf is not
    # found in the lookup)
    if not pdf_prompt:
        pdf_prompt = pdf_lookup2.get("Bank Products")
        pdf_folder = pdf_prompt[0]
        pdf_file = pdf_prompt[1]

    pdf_selected = pdf_folder + "/" + pdf_file

output_lookup2 = {
    "Chatbot Query": ("Chatbot Query", "Prompt1"),
    "Draft Email": ("Draft Email", "Prompt2")
}

output_prompt = "Prompt1"

def update_output(output_choice):
    global output_prompt
    
    # to refer to the gobal variabl enamed odel    
    output_selected = output_lookup2.get(output_choice)[1]
    display_output = output_lookup2.get(output_choice)[0]
    output_prompt = output_selected

    # in case the user selects an invalid value (the new_pdf is not
    # found in the lookup)
    if not output_prompt:
        output_choice = 1  # Default to Chatbot Query if invalid choice
        output_selected = "Prompt1"
        display_output = "Chatbot Query"
        output_prompt = output_selected

css_code = """
.gradio-container button.primary {
    background-color: lightblue !important; /* lightblue */
    color: darkgreen !important;
}
"""

custom_css = """
.my-custom-class {
    background-color: lightblue;
    padding: 10px;
    border-radius: 5px;
}

.another-class {
    color: white;
    font-weight: bold;
}

p.first-letter::first-letter {
    all: unset;
    font-size: 1.5em;
    color: white;
    background-color: black;
    border-radius: 2px;
    box-shadow: 3px 3px 0 red;
    font-size: 150%;
    padding: 3px 3px;
    margin-right: 3px;
    float: left;
}
"""
def custom_clear_action():
    print("Clear button was clicked! Performing custom actions...")
    # You can add any custom logic here, e.g., resetting other components
    # or logging information.
    # language_selected = "English"
    # display_language = "English"
    language_choice = 1
    process(language_choice)
    return

def reset_dropdown_to_default():
    return 1 # Replace with your desired default value for the dropdown (e.g., 1 for English)

dropdown_component = gr.Dropdown(
                choices=[
                    ("English", 1),
                    ("中文", 2)
                ],
                label="Please choose your Chat Language:",
                value=1
            )

# output_component = gr.Markdown("## The Default Chat Language is <span style='color: blue;'>English</span>")

output_component = gr.Markdown()

def render_ui():
    # --- UI (Gradio v5) ---
    with gr.Blocks(theme=gr.themes.Soft(primary_hue="blue", secondary_hue="emerald"), css=custom_css) as demo:
        # gr.Markdown("## 📄 PDF Q&A (Gemini + FAISS) — minimal Gradio v5")

        # gr.Markdown("<h1 style='text-align: center;'> 📄 **HeiFinance Bank Q&A Chatbot** </h1>")
        gr.HTML("""
            <div style='height: 100px; width: 400px; background-color: pink; color: red; margin: auto; border-radius: 10px;'>
                <h1 style='text-align: center; padding-top: 30px; font-size: 20px;'>
                <p class="first-letter">📄<b style='color: blue; margin-left: 3px'>HeiFinance Bank <span style="font-variant: small-caps; font-size: 4vh; color: red;">Q&A</span> Chatbot</b></p>
                </h1>
            </div>
        """)
        
        gr.Markdown("### Step 0: Please choose the Chat Language from 'Dropdown Menu' and click 'Submit Chat Language' button.")
        gr.Markdown("## The Default Chat Language is <span style='color: blue;'>English</span>")

        my_interface = gr.Interface(
            fn=process,
            inputs=[
                dropdown_component
            ],
            outputs=[
                output_component
            ],
            flagging_mode="never",
            clear_btn="Clear Chat Language",
            submit_btn="Submit Chat Language",
            live=False, # Both Clear Button and Submit Button
            # live=True,  # Clear Button only
            css=css_code
        )

        # with my_interface: # If using Blocks, otherwise directly after interface definition
        #     clear_btn = gr.ClearButton(value="Clear")
        #     clear_btn.click(
        #         fn=reset_dropdown_to_default,
        #         inputs=[],
        #         outputs=[dropdown_component]
        #     )

        #     my_interface.output_component = my_interface.input_components[0]  # Assuming the first input is the dropdown
        
        gr.Markdown("### Step 1: Please choose the Chat Category from 'Radio' button and select your Output Type.")

        # gr.Radio here: create an interface for the user to choose the personality
        # have at least three - 1) helpful assistant, 2)snarky and sarcasic, 3) lazy and unmotiviated
        with gr.Row():
            with gr.Column(scale=3):
                pdf = gr.Radio(choices=[
                    ("Annual Report", "Annual Report"),
                    ("Bank Products", "Bank Products"),
                    ("Employee Handbook", "Employee Handbook"),
                    ("Organisation Chart", "Organisation Chart"),
                    ("Phone Directory", "Phone Directory")
                ], label="Chat Category", value="Bank Products")

                pdf.change(
                    fn = update_pdf,
                    inputs = [pdf]
                )

            with gr.Column(scale=1):
                output_type = gr.Radio(choices=[
                    ("Chatbot Query", "Chatbot Query"),
                    ("Draft Email", "Draft Email")
                ], label="Please select your Output Type", value="Chatbot Query")

                output_type.change(
                    fn = update_output,
                    inputs = [output_type]
                )

        # with gr.Row():
        #     # Return a real filesystem path to do_build
        #     pdf_file = gr.File(label="Upload PDF", type="filepath", file_types=[".pdf"], file_count="single")

        # with gr.Row():
        #     chunk_size = gr.Number(value=1200, label="Chunk size", precision=0)
        #     overlap = gr.Number(value=200, label="Overlap", precision=0)
        #     top_k = gr.Number(value=4, label="Top-K", precision=0)
        #     # top_k = gr.Slider(1, 10, value=4, step=1, label="Top-K")

        gr.Markdown("### Step 2: Please click 'Build Index' button to start.")
        build_btn = gr.Button("Build Index", variant="primary", elem_classes=["my-custom-class", "another-class"])
        # status = gr.Markdown("")        
        status = gr.Markdown("")
        current_file_status = gr.Markdown("")
        

        chatbot = gr.Chatbot(height=420, label="HeiFinance Chatbox")
        gr.Markdown("### Step 3: Please type your query in the Textbox below.")
        msg = gr.Textbox(label="Ask a question", placeholder="Type and press Enter", elem_classes="my-custom-class")
        gr.Markdown("### Step 4 (optional): To clear conversations, click 'Clear HeiFinance Chatbox' button.")
        # my_interface.output_component = my_interface.input_components[0]  # Assuming the first input is the dropdown
        clear_chatbox_btn = gr.Button("Clear HeiFinance Chatbox", elem_classes=["my-custom-class", "another-class"])

        # States
        st_chunks = gr.State([])
        st_index = gr.State(None)
        st_top_k = gr.State(4)

        # Wire events (no queue)
        build_btn.click(
            do_build,
            # inputs=[pdf_file, chunk_size, overlap, top_k],
            inputs=[],
            outputs=[status, st_chunks, st_index, st_top_k, current_file_status],
            show_progress=True,   # button spinner; no gradio queue used
        )

        msg.submit(
            do_ask,
            inputs=[msg, chatbot, st_chunks, st_index, st_top_k],
            outputs=[chatbot, msg],
            show_progress=True,
        )

        clear_chatbox_btn.click(lambda: ([], ""), outputs=[chatbot, msg])

        gr.HTML("""
            <h6 style="text-align: right; margin-right: 15px;">Coder: <span style="font-variant:small-caps; font-size: 3vh; color: red;">Ng Yew Seng</span></h6>    
            <h6 style="text-align: right; margin-right: 15px;">Copyright 2025 &#169; Trent Global College</h6>
            <h6 style="text-align: right; margin-right: 15px;">All Rights Reserved </h6>
        """)
        demo.launch(share=False, debug=True) # Running on local URL:  http://127.0.0.1:7860
        # demo.launch(share=True)  # Public URL:  https://xxxx.gradio.app
        # demo.launch(server_name="0.0.0.0", server_port=7860, share=False) # use a tunneling tool (ngrok/localtunnel)

# ...existing code...
# Run locally only:
# demo.launch(share=False)

# Or equivalent (default is local):
# demo.launch()

# If you need a public URL, ensure you have internet and Gradio's service is reachable,
# or use a tunneling tool (ngrok/localtunnel) and set server_name="0.0.0.0" with an open port.
# demo.launch(server_name="0.0.0.0", server_port=7860, share=False)
# ...existing code...

# def do_build(pdf_path, chunk_size, overlap, top_k):
def do_build():
    pdf_path = "./pdf-HeiFinance/" + str(pdf_selected)

    chunk_size = "1200"
    overlap = "200"
    top_k = "4"

    if not pdf_path:
        raise gr.Error("Please upload a PDF first.")

    # Extract text (inline, same as your notebook)
    reader = PdfReader(pdf_path)
    pages = []
    for p in reader.pages:
        try:
            pages.append(p.extract_text() or "")
        except Exception:
            pages.append("")
    full_text = "\n".join(pages)

    # Chunk
    chunks = make_chunks(full_text, chunk_size=int(chunk_size), overlap=int(overlap))
    if not chunks:
        raise gr.Error("No text extracted from the PDF. Is it a scanned PDF without OCR?")

    # Embed + FAISS index (your functions, your client)
    vecs = create_embeddings(chunks, client, batch_size=32)
    index = build_faiss_index(vecs)

    status = f"Ready. {len(chunks)} chunks; index size={index.ntotal}."
    
    gr.Info("Index built successfully!")

    message = f"You may start your query on {pdf_folder} now!"
    gr.Info(message)
    current_file_status = f"Current loaded PDF file: {pdf_file}."
    return status, chunks, index, int(top_k), current_file_status

# Ask a question using your retrieval + prompting + generation helpers
def do_ask(message, history, chunks, index, top_k):
    if index is None or not chunks:
        raise gr.Error("Please build the index first.")

    hits = retrieve(message, index, chunks, client, k=int(top_k), model_name=EMBED_MODEL)
    contexts = [h[0] for h in hits]
    prompt = build_prompt(message, contexts, output_prompt=output_prompt)
    rag_answer = generate_answer(prompt, client, model_name=GEN_MODEL)
    if language_selected == "Chinese":
        answer = respond_text_in_system_language(rag_answer, client, system_language=language_selected, model_name=GEN_MODEL)
    else:
        answer = rag_answer  
    # answer = respond_text_in_system_language(rag_answer, client, system_language=language_selected, model_name=GEN_MODEL)
    # translated_answer = translate_text(rag_answer, client, target_language=language_selected, model_name=GEN_MODEL)

    # Simple source previews (optional, still KISS)
    # if hits:
    #     src_lines = []
    #     for rank, (_, score, idx) in enumerate(hits, start=1):
    #         preview = chunks[idx][:160].replace("\n", " ")
    #         src_lines.append(f"[{rank}] Chunk {idx} • score={score:.4f} • “{preview}…”")
    #     answer = f"{answer}\n\n---\n**Sources**\n" + "\n".join(src_lines)

    # history = history + [(message, rag_answer)]
    history = history + [(message, answer)]
    # history = history + [(message, translated_answer)]
    return history, ""

render_ui()