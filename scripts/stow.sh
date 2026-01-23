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
echo "Running stowing script..."
echo "----------------------------"

# Check config file
if [[ ! -f "$CONFIG_PATH" ]]; then
	echo "Error: $CONFIG_PATH not found!"
	exit 1
fi

echo
$SCRIPT_DIR/clean.sh && wait

# Copy all files and folders from src to dst
copy_all_files_and_folders_from_src_to_dst() {
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

# Process function
process_section() {
	local section="$1"
	echo "Section: $section"

	# section must be an object
	if ! jq -e ".\"$section\" | type == \"object\"" "$CONFIG_PATH" >/dev/null; then
		echo "Section '$section' (not an object)"
		exit
	fi

	# get all apps in the section
	local apps
	apps=$(jq -r ".\"$section\" | keys | join(\" \")" "$CONFIG_PATH")
	echo "Apps: $apps"
	echo

	for app in $apps; do
		echo "----------------------------------------"
		echo "Section: $section"
		echo "App: $app"

		echo "----"

		# e.g. config_folder (value): common/state, common/code
		# e.g. config_folder (full path):
		# /Users/quocnguyen/qn/area/repos/dotfiles/common/state,
		# /Users/quocnguyen/qn/area/repos/dotfiles/common/code
		local config_folder
		local config_folder_full_path
		config_folder=$section/$(jq -r ".\"$section\".\"$app\".folder" "$CONFIG_PATH")
		config_folder_full_path="$(cd "$config_folder" 2>/dev/null && pwd -P)"
		echo "Config folder (value): $config_folder"
		echo "Config folder (full path): $config_folder_full_path"

		if [[ "$config_folder" == "null" || ! -d "$config_folder_full_path" ]]; then
			echo "Error: 'config_folder does not exist' or 'config_folder value is null'"
			exit 1
		else
			echo "  = exists:  $config_folder_full_path"
		fi

		echo "----"

		# e.g. target_folder (value): .ssh, .config/nvim, etc
		local target_folder
		target_folder=$(jq -r ".\"$section\".\"$app\".\"$OS\"" "$CONFIG_PATH")
		echo "Target folder (value): $target_folder"

		if [[ "$target_folder" == "null" ]]; then
			echo "Error: 'target_folder value is null'"
			exit 1
		fi

		# e.g. target_folder (HOME path): /Users/quocnguyen/.ssh, /home/quocnguyen/.config/nvim, etc
		local target_folder_home_path
		target_folder_home_path="$HOME/$target_folder"
		echo "Target folder (HOME path): $target_folder_home_path"

		make_dir_if_not_exists "$target_folder_home_path"
		[[ $? -eq 1 ]] && echo "  + created: $target_folder_home_path" || echo "  = exists:  $target_folder_home_path"

		echo "----"

		# e.g. target_folder_app (full path): /Users/quocnguyen/qn/area/repos/dotfiles/apps/.ssh
		local target_folder_app
		target_folder_app="$APPS_DIR/$target_folder"
		echo "App folder: $target_folder_app"

		make_dir_if_not_exists "$target_folder_app"
		[[ $? -eq 1 ]] && echo "  + created: $target_folder_app" || echo "  = exists:  $target_folder_app"

		# Handle absolute path
		# # If path starts with / → absolute
		# if [[ "$path" == /* ]]; then
		#     home_path="$path"
		#     app_path="$APP_DIR$path"
		# fi

		# Copy config files if folder exists
		if [[ -d "$config_folder_full_path" ]]; then
			copy_all_files_and_folders_from_src_to_dst "$config_folder_full_path" "$target_folder_app"
			echo "  → copied configs from $config_folder_full_path to $target_folder_app"
		else
			echo "  (no local config folder: $config_folder_full_path)"
		fi

		echo "----------------------------------------"
	done
}

echo "Processing common..."
process_section "common"

if [[ "$OS" == "macos" ]]; then
	echo "Processing macos..."
	process_section "macos"
elif [[ "$OS" == "ubuntu" ]]; then
	echo "Processing ubuntu..."
	process_section "ubuntu"
else
	echo "Error: OS must be macos or ubuntu"
	exit 1
fi

# Fix SSH dir permissions
fix_ssh_permissions() {
	make_dir_if_not_exists "$HOME/.ssh"

	if [[ "$OS" == "macos" ]]; then
		chown -R "$USER" "$HOME/.ssh"
	else
		chown -R "$USER":"$USER" "$HOME/.ssh"
	fi

	chmod 700 "$HOME/.ssh"
}

fix_ssh_permissions

exit 0
