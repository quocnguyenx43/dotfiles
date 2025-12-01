#!/usr/bin/env bash

# ----------------------------------------
# Resolve script directory
# ----------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$SCRIPT_DIR/../common"
STATE_DIR="$SCRIPT_DIR/../state"
MACOS_DIR="$SCRIPT_DIR/../macos"
UBUNTU_DIR="$SCRIPT_DIR/../ubuntu"
CONFIG_FILE="$SCRIPT_DIR/../config/paths.json"
APP_DIR="$SCRIPT_DIR/../apps"

# ----------------------------------------
# Check config file
# ----------------------------------------
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: paths.json not found!"
    exit 1
fi

# ----------------------------------------
# Clean the old first
# ----------------------------------------
echo
$SCRIPT_DIR/clean.sh && wait

# ----------------------------------------
# Helpers
# ----------------------------------------

make_dir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        return 1   # created
    else
        return 0   # exists
    fi
}

copy_all() {
    local src="$1"
    local dest="$2"

    [[ ! -d "$src" ]] && return 0
    mkdir -p "$dest"

    # normal files/folders
    for item in "$src"/*; do
        [[ -e "$item" ]] && cp -r "$item" "$dest/"
    done

    # hidden files/folders
    for item in "$src"/.[!.]*; do
        [[ -e "$item" ]] && cp -r "$item" "$dest/"
    done
}

get_path() {
    local section="$1"  # common / macos / ubuntu
    local app="$2"

    if [[ "$section" == "common" ]]; then
        # common → pick the OS-specific path
        jq -r ".common.\"$app\".\"$OS\"" "$CONFIG_FILE"
    else
        # macos or ubuntu
        jq -r ".\"$section\".\"$app\"" "$CONFIG_FILE"
    fi
}

# ----------------------------------------
# Process function
# ----------------------------------------
process_section() {
    local section="$1"
    echo "Section: $section"

    # section must be an object
    if ! jq -e ".\"$section\" | type == \"object\"" "$CONFIG_FILE" >/dev/null; then
        echo "Section '$section' (not an object)"
        exit
    fi

    local apps
    apps=$(jq -r ".\"$section\" | keys | join(\" \")" "$CONFIG_FILE")
    echo "Apps: $apps"
    echo

    for app in $apps; do
        echo "Processing: $app"

        # e.g. { "macos": "", "ubuntu": "" }
        # e.g. { "macos": ".config/nvim", "ubuntu": ".config/nvim" }
        local path
        path=$(get_path "$section" "$app")
        echo "Path: $path"

        if [[ "$path" == "null" ]]; then
            echo "Skipping $app (null path)"
            continue
        fi

        # Determine full paths
        # e.g. home_path=/home/skibidi/.config/yazi
        # e.g. app_path=/home/skibidi/airair/learn/dotfiles/apps/.config/yazi
        local home_path="$HOME/$path"
        local conf_path="$SCRIPT_DIR/../$section/$app"
        local app_path="$APP_DIR/$path"
        echo "HOME path: $home_path"
        echo "Config path: $conf_path"
        echo "App path: $app_path"

        # # If path starts with / → absolute
        # if [[ "$path" == /* ]]; then
        #     home_path="$path"
        #     app_path="$APP_DIR$path"
        # fi

        # Make directory $home_path and $app_path
        make_dir "$home_path"
        [[ $? -eq 1 ]] && echo "  + created: $home_path" || echo "  = exists:  $home_path"

        make_dir "$app_path"
        [[ $? -eq 1 ]] && echo "  + created: $app_path" || echo "  = exists:  $app_path"

        # Copy config files if folder exists
        if [[ -d "$conf_path" ]]; then
            copy_all "$conf_path" "$app_path"
            echo "  → copied configs from $conf_path/"
        else
            echo "  (no local config folder: $conf_path/)"
        fi

        echo
    done
}

# ----------------------------------------
# Run
# ----------------------------------------

echo
echo "----------------------------------------"

process_section "common"

echo
echo "----------------------------------------"

if [[ "$OS" == "macos" ]]; then
    process_section "macos"
elif [[ "$OS" == "ubuntu" ]]; then
    process_section "ubuntu"
else
    echo "Error: OS must be macos or ubuntu"
    exit 1
fi

# ----------------------------------------
# Fix SSH dir permissions
# ----------------------------------------
fix_ssh_permissions() {
    make_dir "$HOME/.ssh"

    if [[ "$OS" == "macos" ]]; then
        chown -R "$USER" "$HOME/.ssh"
    else
        chown -R "$USER":"$USER" "$HOME/.ssh"
    fi

    chmod 700 "$HOME/.ssh"
}

fix_ssh_permissions

exit 0
