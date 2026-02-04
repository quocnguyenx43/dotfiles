#!/bin/bash

# Linux
if [[ "$OS" == "ubuntu" || "$OS" == "arch" ]]; then
    # Neovim
    if [[ "$ARCH" == "amd64" && -d "/opt/nvim/nvim-linux-x86_64/bin" ]]; then
        export PATH="$PATH:/opt/nvim/nvim-linux-x86_64/bin"
    fi

    # Cargo
    export PATH="$HOME/.cargo/bin:$PATH"

    # Coursier
    export PATH="$PATH:$HOME/.local/share/coursier/bin"
elif [[ "$OS" == "macos" ]]; then
    # Antigravity
    export PATH="$PATH:$HOME/.antigravity/antigravity/bin"

    # Coursier
    export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
fi

# # JVM (via Coursier)
# cs java --jvm temurin:17 --env

# Python
PYTHON_DEFAULT_VER="3.12"
function create_virtual_python_environment() {
    local use_uv="$1"

    if [[ "$use_uv" == "uv" ]]; then
        echo "Initializing project with 'uv' (Python $PYTHON_DEFAULT_VER)..."
        uv init -p "$PYTHON_DEFAULT_VER"
        uv venv -p "$PYTHON_DEFAULT_VER"
        uv sync
        uv add pip

        # Activate
        source .venv/bin/activate
        echo "uv environment created and activated."
    else 
        echo "Creating standard 'venv' (Python $PYTHON_DEFAULT_VER)..."
        "python${PYTHON_DEFAULT_VER}" -m venv .venv

        # Activate & Update
        source .venv/bin/activate
        pip install --upgrade pip
        echo "venv environment created and activated."
    fi
}
alias cpyv="create_virtual_python_environment"  # Create (usage: cpyv or cpyv uv)
alias apyv="source ./.venv/bin/activate"        # Activate
alias dpyv="deactivate"                         # Deactivate

# NodeJS, fnm
eval "$(fnm env --use-on-cd)"

# Docker
alias dkc-stop='docker stop $(docker ps -aq)'
alias dkc-rm='docker rm $(docker ps -aq)'
alias dkv-prune='docker volume prune -f'

# Kubernetes
alias k='kubectl'
alias kc='kubectl-convert'
alias kind='kind'
alias mkb='minikube'
