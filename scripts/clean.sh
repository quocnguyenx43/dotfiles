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
echo "Running cleaning script..."
echo "----------------------------"

# Cleanning apps
if [[ -d "$APPS_DIR" ]]; then
	find "$APPS_DIR" -mindepth 1 -maxdepth 1 ! -name 'Makefile' ! -name '.stowrc' -exec rm -rf {} +
fi
