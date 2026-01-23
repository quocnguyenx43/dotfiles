#!/bin/bash

# Bin paths
if [[ "$OS" == "macos" ]]; then
    if [[ "$ARCH" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/python@3/bin:$PATH"
        CODE_BIN="/opt/homebrew/bin/code"
    elif [[ "$ARCH" == "amd64" ]]; then
        export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
        CODE_BIN="/usr/local/bin/code"
    fi
elif [[ "$OS" == "ubuntu" || "$OS" == "arch" ]]; then
    export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:$PATH"
    CODE_BIN="/usr/bin/code"
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Basic code editor
export EDITOR="$CODE_BIN"

# Complete remove package
case "$OS" in
    ubuntu)
        # APT (Ubuntu/Debian)
        crm_func() {
            echo "Purging package via APT..."
            sudo apt-get remove --auto-remove --purge "$1"
            sudo apt-get clean
            sudo apt-get autoremove -y
        }
        ;;
        
    arch)
        # PACMAN (Arch Linux)
        crm_func() {
            echo "Removing package via Pacman (Recursive + Configs)..."
            # -R: Remove, -n: No backups, -s: Recursive deps
            sudo pacman -Rns "$1"
        }
        ;;
        
    macos)
        # HOMEBREW (macOS)
        crm_func() {
            echo "Uninstalling package via Homebrew..."
            brew uninstall --force "$1"
            brew cleanup
        }
        ;;
        
    *)
        crm_func() {
            echo "Error: Unknown OS '$OS' for crm command."
        }
        ;;
esac
alias crm="crm_func"
