#!/bin/bash
set -e

# Identity OS and then run the appropriate script
OS_TYPE="$(uname)"

if [[ "$OS_TYPE" == "Linux" ]]; then
    OS_NAME="$(lsb_release -si)"
    OS_VERSION="$(lsb_release -sr)"
    echo "OS: $OS_NAME $OS_VERSION"
    ./ubuntu.sh && wait
elif [[ "$OS_TYPE" == "Darwin" ]]; then
    OS_NAME="macOS"
    OS_VERSION="$(sw_vers -productVersion)"
    echo "OS: $OS_NAME $OS_VERSION"
    ./macos.sh && wait
else
    echo "Unsupported OS: $OS_TYPE"
    exit 1
fi

# Define the path to the JSON file
JSON_FILE="conf_dirs.json"

# Function to create directories based on the OS
create_dirs() {
    if [[ ! -f "$JSON_FILE" ]]; then
        echo "JSON file not found!"
        exit 1
    fi

    for app in $(jq -r 'keys[]' "$JSON_FILE"); do
        for os in $(jq -r ".${app} | keys[]" "$JSON_FILE"); do
        if [[ "$os" == "MacOS" && "$OS_TYPE" == "Darwin" ]]; then
            # Create directories for MacOS
            path=$(jq -r ".${app}.MacOS.path" "$JSON_FILE")
            mkdir -p "$HOME/$path" && mkdir -p "../MacOS/$path"
            echo "$app MacOS dir:"
            echo "--- at: $HOME/$path"
            echo "--- at: ../MacOS/$path"

            # Copy files and folders into ../MacOS
            files_folders=$(jq -r ".${app}.MacOS.files_folders[]" "$JSON_FILE")
            for item in $files_folders; do
            if [[ -e "$item" ]]; then
                cp -r "$item" "../MacOS/$path"
                echo "Copied $item -> ../MacOS/$path"
            else
                echo "Warning: $item does not exist."
            fi
            done
        elif [[ "$os" == "Linux" && "$OS_TYPE" == "Linux" ]]; then
            # Create directories for Linux
            path=$(jq -r ".${app}.Linux.path" "$JSON_FILE")        
            mkdir -p "$HOME/$path" && mkdir -p "../Linux/$path"
            echo "$app Linux dir:"
            echo "--- at: $HOME/$path"
            echo "--- at: ../Linux/$path"

            # Copy files and folders into ../Linux
            files_folders=$(jq -r ".${app}.Linux.files_folders[]" "$JSON_FILE")
            for item in $files_folders; do
            if [[ -e "$item" ]]; then
                cp -r "$item" "../Linux/$path"
                echo "Copied $item -> ../Linux/$path"
            else
                echo "Warning: $item does not exist."
            fi
            done
        fi
        done
    done
}

create_dirs

if [[ "$OS_TYPE" == "Linux" ]]; then
    cp -r .stowrc ../Linux/
    cp -r Makefile ../Linux/
elif [[ "$OS_TYPE" == "Darwin" ]]; then
    cp -r .stowrc ../MacOS/
    cp -r Makefile ../MacOS/
else
    echo "Unsupported OS: $OS_TYPE"
    exit 1
fi

echo ""
echo "Copied .stowrc and Makefile susccessfully!"

echo ""
echo "Creating some config folders & files"
sudo mkdir -p $HOME/.ssh
sudo chown -R "$USER":"$USER" ~/.ssh
sudo chmod 700 ~/.ssh

exit