# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $ source C:/ProgramData/miniconda3/Scripts/activate base
# (base) 
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $

# $ which python
# /c/ProgramData/miniconda3/python
# (base) 
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1

# $ which pip
# /c/ProgramData/miniconda3/Scripts/pip
# (base) 
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $

# $ pwd
# /e/source/tgc-cp1
# (base) 
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $ 

# $ pip freeze
# absl-py==2.3.1
# aiofiles==24.1.0
# altair==5.5.0
# ...
# Werkzeug==3.1.3
# win-inet-pton @ file:///C:/ci_311/win_inet_pton_1676425458225/work
# wrapt==1.17.3
# zstandard==0.19.0
# (base) 
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $

# $ pip show pypdf
# Name: pypdf
# Version: 6.2.0
# Summary: A pure-python PDF library capable of splitting, merging, cropping, and transforming PDF files
# Home-page:
# Author:
# Author-email: Mathieu Fenniak <biziqe@mathieu.fenniak.net>
# License-Expression: BSD-3-Clause
# Location: C:\Users\ERIC NG\AppData\Roaming\Python\Python311\site-packages
# Requires:
# Required-by:
# (base) 
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $

# Deactivate conda base environment auto activation
# conda config --set auto_activate_base false

python -m venv venv

# (base) 
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $ 

# source "E:/source/tgc-cp1/venv/Scripts/activate"

source /e/source/tgc-cp1/venv/Scripts/activate

# (base)
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $ 

# pip install --upgrade gradio google-genai pillow dotenv # for image_chat

# pip install --upgrade gradio google-genai dotenv # for text_chat

# pip install numpy faiss-cpu pypdf

# pip install pdfplumber

pip install -r requirements.txt

# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $ bash run-venv.sh
# Collecting gradio
#   Obtaining dependency information for gradio from https://files.pythonhosted.org/packages/8d/95/1c25fbcabfa201ab79b016c8716a4ac0f846121d4bbfd2136ffb6d87f31e/gradio-5.49.1-py3-none-any.whl.metadata
#   Downloading gradio-5.49.1-py3-none-any.whl.metadata (16 kB)
# Collecting google-genai
#   Obtaining dependency information for google-genai from https://files.pythonhosted.org/packages/30/6b/78a7588d9a4f6c8c8ed326a32385d0566a3262c91c3f7a005e4231207894/google_genai-1.50.1-py3-none-any.whl.metadata
#   Downloading google_genai-1.50.1-py3-none-any.whl.metadata (46 kB)
#      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 46.7/46.7 kB 776.4 kB/s eta 0:00:00
# Collecting pillow
#   Obtaining dependency information for pillow from https://files.pythonhosted.org/packages/4d/42/aaca386de5cc8bd8a0254516957c1f265e3521c91515b16e286c662854c4/pillow-12.0.0-cp311-cp311-win_amd64.whl.metadata
#   Downloading pillow-12.0.0-cp311-cp311-win_amd64.whl.metadata (9.0 kB)
# Collecting aiofiles<25.0,>=22.0 (from gradio)
#   Obtaining dependency information for aiofiles<25.0,>=22.0 from https://files.pythonhosted.org/packages/a5/45/30bb92d442636f570cb5651bc661f52b610e2eec3f891a5dc3a4c3667db0/aiofiles-24.1.0-py3-none-any.whl.metadata

# Installing collected packages: pytz, pydub, brotli, websockets, urllib3, tzdata, typing-extensions, tomlkit, tenacity, sniffio, six, shellingham, semantic-version, ruff, pyyaml, python-multipart, pygments, pyasn1, pillow, packaging, orjson, numpy, mdurl, markupsafe, idna, hf-xet, h11, groovy, fsspec, filelock, ffmpy, colorama, charset_normalizer, certifi, cachetools, annotated-types, annotated-doc, aiofiles, typing-inspection, tqdm, rsa, requests, python-dateutil, pydantic-core, pyasn1-modules, markdown-it-py, jinja2, httpcore, click, anyio, uvicorn, typer-slim, starlette, rich, pydantic, pandas, httpx, google-auth, typer, safehttpx, huggingface-hub, google-genai, fastapi, gradio-client, gradio    
# Successfully installed aiofiles-24.1.0 annotated-doc-0.0.4 annotated-types-0.7.0 anyio-4.11.0 brotli-1.2.0 cachetools-6.2.2 certifi-2025.11.12 charset_normalizer-3.4.4 click-8.3.0 colorama-0.4.6 fastapi-0.121.2 ffmpy-1.0.0 filelock-3.20.0 fsspec-2025.10.0 google-auth-2.43.0 google-genai-1.50.1 gradio-5.49.1 gradio-client-1.13.3 groovy-0.1.2 h11-0.16.0 hf-xet-1.2.0 httpcore-1.0.9 httpx-0.28.1 huggingface-hub-1.1.4 idna-3.11 jinja2-3.1.6 markdown-it-py-4.0.0 markupsafe-3.0.3 mdurl-0.1.2 numpy-2.3.4 orjson-3.11.4 packaging-25.0 pandas-2.3.3 pillow-11.3.0 pyasn1-0.6.1 pyasn1-modules-0.4.2 pydantic-2.11.10 pydantic-core-2.33.2 pydub-0.25.1 pygments-2.19.2 python-dateutil-2.9.0.post0 python-multipart-0.0.20 pytz-2025.2 pyyaml-6.0.3 requests-2.32.5 rich-14.2.0 rsa-4.9.1 ruff-0.14.5 safehttpx-0.1.7 semantic-version-2.10.0 shellingham-1.5.4 six-1.17.0 sniffio-1.3.1 starlette-0.49.3 tenacity-9.1.2 tomlkit-0.13.3 tqdm-4.67.1 typer-0.20.0 typer-slim-0.20.0 typing-extensions-4.15.0 typing-inspection-0.4.2 tzdata-2025.2 urllib3-2.5.0 uvicorn-0.38.0 websockets-15.0.1

# [notice] A new release of pip is available: 23.2.1 -> 25.3
# [notice] To update, run: python.exe -m pip install --upgrade pip

# (base)
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $