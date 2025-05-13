#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

NOTIFY_SCRIPT="${HOME}/.osascripts/show-notification.applescript"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <message>"
    exit 1
fi

MESSAGE="$1"

osascript "$NOTIFY_SCRIPT" "$MESSAGE"