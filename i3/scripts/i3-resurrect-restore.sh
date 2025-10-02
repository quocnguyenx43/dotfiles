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

# Check if workspace list file exists
if [ ! -f "$WORKSPACE_LIST_FILE" ]; then
    echo "Error: Workspace list file not found at $WORKSPACE_LIST_FILE" >&2
    echo "Please run the save script first to create saved workspaces." >&2
    exit 1
fi

# Check if i3-resurrect binary exists and is executable
if [ ! -x "$I3_RESURRECT_BIN" ]; then
    echo "Error: i3-resurrect binary not found or not executable at $I3_RESURRECT_BIN" >&2
    exit 1
fi

echo "Starting workspace restoration..."
echo "Reading workspaces from: $WORKSPACE_LIST_FILE"

# Counter for statistics
restored_count=0
failed_count=0

# Restore each workspace
while IFS= read -r ws; do
    # Skip empty lines
    [ -z "$ws" ] && continue
    
    echo "🔁 Restoring workspace: $ws"
    notify-send "🔁 Restoring workspace: $ws"
    
    # Run i3-resurrect restore command
    if "$I3_RESURRECT_BIN" restore -w "$ws"; then
        echo "✅ Successfully restored workspace: $ws"
        ((restored_count++))
    else
        echo "❌ Failed to restore workspace: $ws" >&2
        ((failed_count++))
    fi
    
    # Small delay between restores to avoid overwhelming the system
    sleep 0.5
    
done < "$WORKSPACE_LIST_FILE"

# Final summary
echo ""
echo "🎉 Workspace restoration complete!"
echo "✅ Successfully restored: $restored_count workspaces"
if [ $failed_count -gt 0 ]; then
    echo "❌ Failed to restore: $failed_count workspaces"
fi
echo "📋 Total workspaces processed: $((restored_count + failed_count))"

# Show final notification
if [ $failed_count -eq 0 ]; then
    notify-send "🎉 All workspaces restored successfully!" "Restored $restored_count workspaces"
else
    notify-send "⚠️ Workspace restoration completed with errors" "Restored: $restored_count, Failed: $failed_count"
fi
