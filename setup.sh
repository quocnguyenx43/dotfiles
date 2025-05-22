#!/bin/bash

# Parse command line arguments
RUN_OS_SETUP=true
while [[ $# -gt 0 ]]; do
    case $1 in
        --no-os-setup)
            RUN_OS_SETUP=false
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--no-os-setup]"
            exit 1
            ;;
    esac
done

# Get PC_TYPE: PERSONAL | WORK
PC_TYPE_FILE="$HOME/.zsh_pc_type"

if [[ ! -f "$PC_TYPE_FILE" ]]; then
    read "?Please enter your PC_TYPE (e.g., PERSONAL or WORK): " PC_TYPE
    echo "$PC_TYPE" > "$PC_TYPE_FILE"
fi

# OS Detection
OS_FILE="$HOME/.zsh_os"
OS_VERSION_FILE="$HOME/.zsh_os_version"
ARCH_FILE="$HOME/.zsh_arch"

if [[ ! -f "$OS_FILE" || ! -f "$OS_VERSION_FILE" || ! -f "$ARCH_FILE" ]]; then
    if [[ "$(uname)" == "Darwin" ]]; then
        OS="macos"
        OS_VERSION=$(sw_vers -productVersion)
        if [[ "$(uname -m)" == "arm64" ]]; then
            ARCH="arm64"
        else
            ARCH="amd64"
        fi
    elif [[ "$(uname)" == "Linux" ]] && [[ -f "/etc/lsb-release" ]] && grep -q "Ubuntu" "/etc/lsb-release"; then
        OS="ubuntu"
        OS_VERSION=$(lsb_release -rs)
        if [[ "$(uname -m)" == "aarch64" ]]; then
            ARCH="arm64"
        else
            ARCH="amd64"
        fi
    else
        echo "Error: This script only supports macOS and Ubuntu"
        exit 1
    fi
    
    echo "$OS" > "$OS_FILE"
    echo "$OS_VERSION" > "$OS_VERSION_FILE"
    echo "$ARCH" > "$ARCH_FILE"
else
    OS=$(cat "$OS_FILE")
    OS_VERSION=$(cat "$OS_VERSION_FILE")
    ARCH=$(cat "$ARCH_FILE")
fi

# Define the config path JSON file
JSON_CONF_DIR_FILE="conf_dirs.json"
OUTPUT_DIR=".outputs"

# Function to create directories based on the OS
if [[ ! -f "$JSON_CONF_DIR_FILE" ]]; then
    echo "JSON conf dir file not found!"
    exit 1
fi

# Function to make dir easier
make_dir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        return 1
    else
        return 0 
    fi
}

replicate_structure() {
    local src="$1"
    local dest="$2"

    if [ ! -d "$src" ]; then
        return 1
    fi

    local abs_src=$(realpath "$src")
    local abs_dest=$(realpath "$dest")

    mkdir -p "$abs_dest"

    find "$abs_src" -type d | while read -r dir; do
        rel_path="${dir#$abs_src}"
        echo "mkdir $abs_dest$rel_path"
        mkdir -p "$abs_dest$rel_path"
    done
}

./clean.sh && wait

# Create dirs based on OS
for app in $(jq -r 'keys[]' "$JSON_CONF_DIR_FILE"); do
    path=""
    
    # Get path based on OS
    if [[ "$OS" == "macos" ]]; then
        path=$(jq -r ".${app}.macos" "$JSON_CONF_DIR_FILE")
    elif [[ "$OS" == "ubuntu" ]]; then
        path=$(jq -r ".${app}.ubuntu" "$JSON_CONF_DIR_FILE")
    else
        echo "Error: This script only supports macOS and Ubuntu"
        exit 1
    fi

    # Skipping for some apps doesnt have on this OS
    if [[ "$path" == "null" ]]; then
        echo "Skipping $app: Does not supported on $OS!"
        continue
    fi

    # Create directories

    # If the path is absolute
    if [[ "$path" = /* ]]; then
        res1=$(make_dir "$path")
        res2=$(make_dir "./$OUTPUT_DIR$path")

        echo "$app - $OS directories (absolute path):"
        if [[ $res1 -eq 1 ]]; then
            echo "   - created: $path"
        else
            echo "   - exists: $path"
        fi
        if [[ $res2 -eq 1 ]]; then
            echo "   - created: ./$OUTPUT_DIR$path"
        else 
            echo "   - exists: ./$OUTPUT_DIR$path"
        fi
    else
        res1=$(make_dir "$HOME/$path")
        res2=$(make_dir "./$OUTPUT_DIR/$path")
        
        echo "$app - $OS directories:"
        if [[ $res1 -eq 1 ]]; then
            echo "   - created: $HOME/$path"
        else
            echo "   - exists: $HOME/$path"
        fi
        if [[ $res2 -eq 1 ]]; then
            echo "   - created: ./$OUTPUT_DIR/$path"
        else 
            echo "   - exists: ./$OUTPUT_DIR/$path"
        fi
    fi

    # replicate_structure $app "$HOME/$path"

    # Copy all config files for each app
    if [[ -d "$app" ]]; then
        # Regular file and folder
        for item in "$app"/*; do
            if [[ -e "$item" ]]; then
                cp -r "$item" "$OUTPUT_DIR/$path/"
            fi
        done

        # Hiddne file and folder
        for item in "$app"/.[!.]*; do
            if [[ -e "$item" ]]; then
                cp -r "$item" "$OUTPUT_DIR/$path/"
            fi
        done
    fi
done

make_dir "$HOME/.ssh"

if [[ "$OS" == "macos" ]]; then
    chown -R $USER "$HOME/.ssh"
elif [[ "$OS" == "ubuntu" ]]; then
    chown -R "$USER":"$USER" "$HOME/.ssh"
else
    echo "Error: This script only supports macOS and Ubuntu"
    exit 1
fi

chmod 700 "$HOME/.ssh"

echo

# Configuring for each OS
if [[ "$RUN_OS_SETUP" != "false" ]]; then
    if [[ "$OS" == "macos" ]]; then
        echo "Configuring macOS..."
        echo "OS Version: $OS_VERSION"
        chmod +x ./os_settings/macos-settings.sh && ./os_settings/macos-settings.sh && wait
        chmod +x ./os_settings/macos-tools.sh && ./os_settings/macos-tools.sh && wait
    elif [[ "$OS" == "ubuntu" ]]; then
        echo "Configuring Ubuntu..."
        echo "OS Version: $OS_VERSION"
        echo "Configuring Ubuntu..."
        chmod +x ./os_settings/ubuntu-settings.sh && sudo ./os_settings/ubuntu-settings.sh && wait
        chmod +x ./os_settings/ubuntu-tools.sh && sudo ./os_settings/ubuntu-tools.sh && wait
        chmod +x ./os_settings/ubuntu-monitor-selection.sh && ./os_settings/ubuntu-monitor-selection.sh && wait
        chmod +x ./os_settings/ubuntu-monitor-setup.sh && ./os_settings/ubuntu-monitor-setup.sh && wait
    else
        exit 1
    fi
fi

echo

exit 0