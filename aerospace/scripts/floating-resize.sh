#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# Check valid args
if [ $# -lt 2 ]; then
    echo "Usage: $0 <width_adjustment> <height_adjustment>"
    exit 1
fi

osascript "${HOME}/.osascripts/resize-window.applescript" "$1" "$2"
