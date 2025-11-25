#!/usr/bin/env bash
# filepath: e:\source\tgc-cp1\setup-environment.sh
set -euo pipefail

# Run from repo root
cd "$(dirname "$0")"

# Optionally override python executable: PYTHON=python3 ./setup-environment.sh
PYTHON=${PYTHON:-python}

echo "Using Python: $PYTHON"

# Create venv if not exists
if [ ! -d "venv" ]; then
  echo "Creating virtual environment..."
  $PYTHON -m venv venv
else
  echo "Virtual environment already exists."
fi

# Activate venv (Git Bash / Windows or Unix)
if [ -f "venv/Scripts/activate" ]; then
  # Git Bash / Windows activation
  source venv/Scripts/activate
elif [ -f "venv/bin/activate" ]; then
  # Linux / WSL / macOS
  source venv/bin/activate
else
  echo "ERROR: No venv activation script found (checked venv/Scripts/activate and venv/bin/activate)"
  exit 1
fi

# Upgrade pip and install dependencies
# pip install --upgrade pip
# pip install -r requirements.txt

pip install --upgrade gradio google-genai dotenv
pip install numpy faiss-cpu pypdf
# pip install google-generativeai 

echo "All dependencies installed."

echo "Setup complete. To start the app, run:"
echo "  bash run-gradio.sh"
echo "Or run directly with python:"
echo "  python pdf_chat.py"
