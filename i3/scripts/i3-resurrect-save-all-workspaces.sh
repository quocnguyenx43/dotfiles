#!/usr/bin/env bash

I3_RESURRECT_BIN="/opt/i3-resurrect/.venv/bin/i3-resurrect"
WORKSPACE_LIST_FILE="$HOME/.config/i3/saved_workspaces.txt"

> "$WORKSPACE_LIST_FILE"

workspace_names=$(i3-msg -t get_workspaces | jq -r '.[].name')
for ws in $workspace_names; do
    notify-send "💾 Saving workspace: $ws"
    echo "$ws" >> "$WORKSPACE_LIST_FILE"
    "$I3_RESURRECT_BIN" save -w "$ws" --swallow=class,instance,title
done