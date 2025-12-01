#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## Package maneger: Homebrew
# chmod +x ./brew/brew.sh && ./brew/brew.sh && wait
echo "Homebrew setup done"

## Tilling window: Starting Yabai
# if command -v yabai >/dev/null 2>&1; then
#     yabai --start-service
#     echo "Yabai is started."
# else
#     echo "Running Yabai but Yabai is not installed."
# fi
# echo "Yabai setup done"

## Shortcut deamon: skhd
if command -v skhd >/dev/null 2>&1; then
    skhd --start-service
    echo "skhd is started."
else
    echo "Running skhd but skhd is not installed."
fi
echo "skhd setup done"