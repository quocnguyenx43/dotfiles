#!/usr/bin/env bash

if [ -f ./utils.sh ]; then
	source ./utils.sh
elif [ -f ./scripts/utils.sh ]; then
	source ./scripts/utils.sh
else
	echo "Error: utils.sh not found in the same directory as this script"
	exit 1
fi

SCRIPT_DIR=$(get_script_dir)
STATE_DIR=$(get_clean_absolute_path "$SCRIPT_DIR/../common/state")
COMMON_DIR=$(get_clean_absolute_path "$SCRIPT_DIR/../common")
UBUNTU_DIR=$(get_clean_absolute_path "$SCRIPT_DIR/../ubuntu")
MACOS_DIR=$(get_clean_absolute_path "$SCRIPT_DIR/../macos")
APPS_DIR=$(get_clean_absolute_path "$SCRIPT_DIR/../apps")
CONFIG_PATH=$(get_clean_absolute_path "$SCRIPT_DIR/../config")/paths.json
SECRET_PATH=$(get_clean_absolute_path "$SCRIPT_DIR/../config")/secrets.json

echo "Script directory: $SCRIPT_DIR"
echo "State directory: $STATE_DIR"
echo "Common directory: $COMMON_DIR"
echo "Ubuntu directory: $UBUNTU_DIR"
echo "MacOS directory: $MACOS_DIR"
echo "Apps directory: $APPS_DIR"
echo "Config file path: $CONFIG_PATH"
echo "Secret file path: $SECRET_PATH"

echo "----------------------------"
echo "Running state script..."
echo "----------------------------"

# ensure directory exists
make_dir_if_not_exists "$STATE_DIR"

OS_FILE="$STATE_DIR/.zsh_os"
OS_VERSION_FILE="$STATE_DIR/.zsh_os_version"
ARCH_FILE="$STATE_DIR/.zsh_arch"

# Helpers

clear_state_dir() {
	local dir="$STATE_DIR"
	find "$dir" -mindepth 1 -maxdepth 1 ! -name '.gitkeep' -exec rm -rf {} +
}

save_var() {
	local value="$1"
	local file="$2"
	echo "$value" >"$file"
}

load_var() {
	local file="$1"
	[[ -f "$file" ]] && cat "$file"
}

# OS Detection

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
get_os_info

echo "OS          = $OS"
echo "OS_VERSION  = $OS_VERSION"
echo "ARCH        = $ARCH"
echo "STATE_DIR   = $STATE_DIR"

export OS OS_VERSION ARCH STATE_DIR
