#!/usr/bin/env bash

# Configuration
I3_RESURRECT_BIN="$HOME/.config/i3/i3-resurrect/.venv/bin/i3-resurrect"
WORKSPACE_LIST_FILE="$HOME/.config/i3/saved_workspaces.txt"

# Function to find the correct i3 socket
find_i3_socket() {
    local socket_dir="/run/user/$UID/i3"
    
    if [ ! -d "$socket_dir" ]; then
        echo "Error: i3 socket directory not found at $socket_dir" >&2
        return 1
    fi
    
    # Find the most recent socket file
    local socket_file=$(find "$socket_dir" -name "ipc-socket.*" -type s -printf "%T@ %p\n" 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)
    
    if [ -z "$socket_file" ]; then
        echo "Error: No i3 socket files found in $socket_dir" >&2
        return 1
    fi
    
    echo "$socket_file"
}

# Function to run i3-msg with correct socket
i3_msg_safe() {
    local socket_file
    socket_file=$(find_i3_socket) || return 1
    
    i3-msg -s "$socket_file" "$@"
}

# Check if i3 is running
if ! pgrep -x i3 > /dev/null; then
    echo "Error: i3 window manager is not running" >&2
    exit 1
fi

# Find and set the correct socket
I3_SOCKET=$(find_i3_socket)
if [ $? -ne 0 ] || [ -z "$I3_SOCKET" ]; then
    echo "Error: Could not find valid i3 socket" >&2
    exit 1
fi

echo "Using i3 socket: $I3_SOCKET"
export I3SOCK="$I3_SOCKET"

# Clear the workspace list file
> "$WORKSPACE_LIST_FILE"

# Get workspace names using the correct socket
echo "Getting workspace list..."
workspace_names=$(i3_msg_safe -t get_workspaces | jq -r '.[].name')

if [ $? -ne 0 ] || [ -z "$workspace_names" ]; then
    echo "Error: Could not get workspace list from i3" >&2
    exit 1
fi

echo "Found workspaces: "
echo $workspace_names

# Save each workspace
for ws in $workspace_names; do
    echo "💾 Saving workspace: $ws"
    notify-send "💾 Saving workspace: $ws"
    echo "$ws" >> "$WORKSPACE_LIST_FILE"
    
    # Run i3-resurrect save command
    if [ -x "$I3_RESURRECT_BIN" ]; then
        "$I3_RESURRECT_BIN" save -w "$ws" --swallow=class,instance,title
        if [ $? -eq 0 ]; then
            echo "✅ Successfully saved workspace: $ws"
        else
            echo "❌ Failed to save workspace: $ws" >&2
        fi
    else
        echo "Error: i3-resurrect binary not found or not executable at $I3_RESURRECT_BIN" >&2
    fi
done

echo "🎉 Finished saving all workspaces!"
echo "Workspace list saved to: $WORKSPACE_LIST_FILE"
