#!/usr/bin/env bash

# ----------------------------------------
# Resolve script directory
# ----------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATE_DIR="$SCRIPT_DIR/../common/state"

mkdir -p "$STATE_DIR" # ensure directory exists

PC_TYPE_FILE="$STATE_DIR/.zsh_pc_type"
OS_FILE="$STATE_DIR/.zsh_os"
OS_VERSION_FILE="$STATE_DIR/.zsh_os_version"
ARCH_FILE="$STATE_DIR/.zsh_arch"

# --------------------------
# Helpers
# --------------------------

clear_state_dir() {
    local dir="$STATE_DIR"
    find "$dir" -mindepth 1 -maxdepth 1 ! -name '.gitkeep' -exec rm -rf {} +
}

save_var() {
    local value="$1"
    local file="$2"
    echo "$value" > "$file"
}

load_var() {
    local file="$1"
    [[ -f "$file" ]] && cat "$file"
}

# --------------------------
# PC TYPE
# --------------------------

get_pc_type() {
    if [[ -f "$PC_TYPE_FILE" ]]; then
        PC_TYPE=$(load_var "$PC_TYPE_FILE")
    else
        read -p "Please enter your PC_TYPE (PERSONAL or WORK): " PC_TYPE
        save_var "$PC_TYPE" "$PC_TYPE_FILE"
    fi
}

# --------------------------
# OS Detection
# --------------------------

detect_macos() {
    OS="macos"
    OS_VERSION=$(sw_vers -productVersion)
    ARCH=$(uname -m)

    [[ "$ARCH" == "arm64" ]] && ARCH="arm64" || ARCH="amd64"
}

detect_ubuntu() {
    OS="ubuntu"
    OS_VERSION=$(lsb_release -rs)
    ARCH=$(uname -m)

    [[ "$ARCH" == "aarch64" ]] && ARCH="arm64" || ARCH="amd64"
}

get_os_info() {
    if [[ -f "$OS_FILE" && -f "$OS_VERSION_FILE" && -f "$ARCH_FILE" ]]; then
        OS=$(load_var "$OS_FILE")
        OS_VERSION=$(load_var "$OS_VERSION_FILE")
        ARCH=$(load_var "$ARCH_FILE")
        return
    fi

    case "$(uname)" in
        Darwin)
            detect_macos
            ;;
        Linux)
            if [[ -f "/etc/lsb-release" ]] && grep -q "Ubuntu" /etc/lsb-release; then
                detect_ubuntu
            else
                echo "Error: Unsupported Linux distro (only Ubuntu supported)."
                exit 1
            fi
            ;;
        *)
            echo "Error: Unsupported OS"
            exit 1
            ;;
    esac

    save_var "$OS" "$OS_FILE"
    save_var "$OS_VERSION" "$OS_VERSION_FILE"
    save_var "$ARCH" "$ARCH_FILE"
}

# Run
clear_state_dir
get_pc_type
get_os_info

echo "PC_TYPE     = $PC_TYPE"
echo "OS          = $OS"
echo "OS_VERSION  = $OS_VERSION"
echo "ARCH        = $ARCH"
echo "STATE_DIR   = $STATE_DIR"

export PC_TYPE OS OS_VERSION ARCH STATE_DIR
