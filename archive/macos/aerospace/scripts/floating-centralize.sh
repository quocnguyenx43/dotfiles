#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# Get screen_width and screen_height from this file
source "${XDG_CONFIG_HOME}/aerospace/scripts/display-info.sh"

# Centralize floating window
osascript "${HOME}/osascripts/centralize-window.applescript" "$screen_width" "$screen_height"
${HOME}/osascripts/bash/show-notification.sh "Floating window centralized" "Aerospace"
