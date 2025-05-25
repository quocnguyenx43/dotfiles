#!/bin/bash

# Reference: os_settings/ubuntu-monitor-setup.sh

PRIMARY=$(cat ~/.zsh_primary_monitor)
SECONDARY=$(cat ~/.zsh_secondary_monitor)
ON_RIGHT=$(cat ~/.zsh_primary_monitor_on_right)

xrandr --output "$PRIMARY" --primary
if [[ "$ON_RIGHT" == "1" ]]; then
    xrandr --output "$SECONDARY" --pos 0x0 --output "$PRIMARY" --primary --pos 1920x0
else
    xrandr --output "$PRIMARY" --pos 0x0 --output "$SECONDARY" --primary --pos 1920x0
fi