#!/bin/bash

# Ask for sudo password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update and upgrade system packages
apt update && apt upgrade -y

# Essential dev pack
apt install -y build-essential software-properties-common
apt install -y git curl wget make
apt install -y htop neofetch
apt install -y p7zip-full p7zip-rar
apt install -y poppler-utils
apt install -y wl-clipboard
apt install -y zsh
apt install -y tmux
apt install -y stow
apt install -y fzf fdfind eza zoxide ripgrep bat jq ffmpeg imagemagick

# Tilling manager
apt install i3 polybar

# Clean up
apt autoremove -y
apt clean