#!/usr/bin/env bash

set -euo pipefail

echo "== qn-dotfiles: environment check =="
echo

check_bin() {
	local name="$1"
	if command -v "$name" >/dev/null 2>&1; then
		printf "  [OK]  %s\n" "$name"
	else
		printf "  [MISSING] %s\n" "$name"
	fi
}

echo "Core CLI:"
check_bin git
check_bin stow
check_bin jq
check_bin zsh
check_bin nvim

echo
echo "Shell / lint tooling:"
check_bin pre-commit
check_bin shfmt
check_bin shellcheck
check_bin stylua

echo
echo "OS-specific:"
uname_out="$(uname)"
case "$uname_out" in
Darwin)
	echo "Detected macOS"
	check_bin brew
	check_bin yabai
	check_bin skhd
	;;
Linux)
	echo "Detected Linux (expecting Ubuntu)"
	check_bin apt
	check_bin i3
	check_bin polybar
	check_bin rofi
	check_bin dunst
	;;
*)
	echo "Unknown OS: $uname_out"
	;;
esac

echo
echo "Done. Missing tools are safe to install later; this script does not modify the system."
