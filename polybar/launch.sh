#!/usr/bin/env bash

export PRIMARY_MONITOR=$(cat ~/.zsh_primary_monitor)
export SECONDARY_MONITOR=$(cat ~/.zsh_secondary_monitor)

# Terminate already running bar instances
polybar-msg cmd quit
# If polybar-msg is not available:
# killall -q polybar

# Launch primary bar
echo "--- Primary bar ---" | tee -a /tmp/primary-bar.log
polybar primary-bar 2>&1 | tee -a /tmp/primary-bar.log & disown

# Launch secondary bar only if SECONDARY_MONITOR is not empty
if [ -n "$SECONDARY_MONITOR" ]; then
    echo "--- Secondary bar ---" | tee -a /tmp/secondary-bar.log
    polybar secondary-bar 2>&1 | tee -a /tmp/secondary-bar.log & disown
fi

echo "Bars launched..."