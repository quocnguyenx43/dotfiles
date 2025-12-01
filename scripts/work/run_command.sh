#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <host> <command>"
    exit 1
fi

PASSWORD_FILE="$HOME/.ssh/passwords.json"

# Check if jq is installed or not
if ! command -v jq &> /dev/null; then
    echo "jq is required but not installed. Install it with: sudo apt install jq"
    exit 1
fi

HOST="$1"
CMD="$2"
PASSWORD=$(jq -r --arg host "$HOST" '.[$host]' "$PASSWORD_FILE")
REMOTE_CMD="echo '$PASSWORD' | sudo -S -i | $CMD"

output=$(ssh -o BatchMode=yes "$HOST" "$REMOTE_CMD" 2>&1)
status=$?

echo "$output"
