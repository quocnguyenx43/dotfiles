#!/usr/bin/env bash

I3_RESURRECT_BIN="/opt/i3-resurrect/.venv/bin/i3-resurrect"
WORKSPACE_LIST_FILE="$HOME/.config/i3/saved_workspaces.txt"

while IFS= read -r ws; do
    notify-send "🔁 Restoring workspace: $ws"
    "$I3_RESURRECT_BIN" restore -w "$ws"
done < "$WORKSPACE_LIST_FILE"