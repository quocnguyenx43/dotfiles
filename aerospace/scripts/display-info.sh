#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# Detect aerospace binary
if command -v aerospace &>/dev/null; then
    AEROSPACE_BIN=$(command -v aerospace)
elif [[ -x /opt/homebrew/bin/aerospace ]]; then
    AEROSPACE_BIN="/opt/homebrew/bin/aerospace"  # Apple Silicon (brew path)
elif [[ -x /usr/local/bin/aerospace ]]; then
    AEROSPACE_BIN="/usr/local/bin/aerospace"     # Intel Mac (brew path)
else
    echo "[ERROR] 'aerospace' command not found." >&2
    exit 1
fi

# Get name of the monitor
monitor_name=$("$AEROSPACE_BIN" list-monitors --focused --format '%{monitor-name}')
case $monitor_name in
    "Built-in Retina Display")
        monitor_name="Color LCD";;
    *) ;;
esac

# Display information on the focused monitor
jq_filter=".SPDisplaysDataType[].spdisplays_ndrvs[] | select(._name == \"${monitor_name}\") | ._spdisplays_resolution"
display_info=$(system_profiler SPDisplaysDataType -json | jq -r "${jq_filter}")

screen_width=$(echo "${display_info}" | cut -d ' ' -f 1)
screen_height=$(echo "${display_info}" | cut -d ' ' -f 3)
