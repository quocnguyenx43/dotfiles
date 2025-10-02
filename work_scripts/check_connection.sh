#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <host>"
    exit 1
fi

PASSWORD_FILE="$HOME/.ssh/passwords.json"

# Check if jq is installed or not
if ! command -v jq &> /dev/null; then
    echo "jq is required but not installed. Install it with: sudo apt install jq"
    exit 1
fi

HOST="$1"
PASSWORD=$(jq -r --arg host "$HOST" '.[$host]' "$PASSWORD_FILE")
REMOTE_CMD="echo '$PASSWORD' | sudo -S -i"

output=$(ssh -o BatchMode=yes "$HOST" "$REMOTE_CMD" 2>&1)
status=$?

if [[ $status -eq 0 ]]; then
    echo "OK"
else
    case "$output" in
        *"Connection timed out"*)
            echo "$HOST: Connection timed out"
            ;;
        *"incorrect password"*)
            echo "$HOST: Incorrect password"
            ;;
        *"No route to host"*)
            echo "$HOST: No route to host"
            ;;
        *"Name or service not known"*)
            echo "$HOST: Hostname not resolved"
            ;;
        *"Permission denied"*)
            echo "$HOST: SSH authentication failed"
            ;;
        *"sudo: a password is required"*)
            echo "$HOST: Sudo password is incorrect"
            ;;
        *"Host key verification failed"*)
            echo "$HOST: SSH host key verification failed"
            ;;
        *"Could not resolve hostname"*)
            echo "$HOST: Invalid hostname"
            ;;
        *"Connection refused"*)
            echo "$HOST: Connection refused"
            ;;
        *)
            echo "$HOST: Unknown error"
            echo $output
            ;;
    esac
fi
