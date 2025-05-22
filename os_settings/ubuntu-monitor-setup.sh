#!/bin/bash

PRIMARY=$(cat ~/.zsh_primary_monitor)
SECONDARY=$(cat ~/.zsh_secondary_monitor)
ON_RIGHT=$(cat ~/.zsh_primary_monitor_on_right)

xrandr --output "$PRIMARY" --primary
if [[ "$ON_RIGHT" == "1" ]]; then
    xrandr --output "$PRIMARY" --primary --left-of "$SECONDARY"
else
    xrandr --output "$PRIMARY" --primary --right-of "$SECONDARY"
fi