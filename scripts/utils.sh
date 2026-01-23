#!/usr/bin/env bash

# set -euo pipefail

# Input: /Users/dotfiles/scripts/utils.sh
# Output: /Users/dotfiles/scripts
get_script_dir() {
	local script_path
	local script_dir
	script_path="${BASH_SOURCE[0]}"
	script_dir=$(cd "$(dirname "$script_path")" && pwd)
	echo "$script_dir"
}

# Input: /Users/dotfiles/scripts/../config
# Output: /Users/dotfiles/config
get_clean_absolute_path() {
	local path="$1"
	clean_path="$(cd "$path" 2>/dev/null && pwd -P)"
	echo "$clean_path"
}

make_dir_if_not_exists() {
	local dir="$1"
	if [[ ! -d "$dir" ]]; then
		mkdir -p "$dir"
		return 1 # created
	else
		return 0 # exists
	fi
}

get_path() {
	local section="$1" # common / macos / ubuntu
	local app="$2"

	if [[ "$section" == "common" ]]; then
		# common → pick the OS-specific path
		jq -r ".common.\"$app\".\"$OS\"" "$CONFIG_PATH"
	else
		# macos or ubuntu
		jq -r ".\"$section\".\"$app\"" "$CONFIG_PATH"
	fi
}

get_path_v2() {
	local path="$1"
	echo "get_path_v2: $path"

	jq -r ".\"$path\"" "$CONFIG_PATH"
}
