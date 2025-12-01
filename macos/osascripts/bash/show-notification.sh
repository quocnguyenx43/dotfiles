#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

NOTIFY_SCRIPT="${HOME}/.osascripts/show-notification.applescript"

if [ $# -lt 2 ]; then
    echo "Usage: $0 <message> <title>"
    exit 1
fi

MESSAGE="$1"
TITLE="$2"

osascript "$NOTIFY_SCRIPT" "$MESSAGE" "$TITLE"