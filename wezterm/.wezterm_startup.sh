#!/bin/bash

if command -v tmux >/dev/null 2>&1; then
    if [ -z "$TMUX" ]; then
        LAST_SESSION=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | tail -n 1)
        if [ -n "$LAST_SESSION" ]; then
            exec tmux attach-session -t "$LAST_SESSION"
            echo "attached to the last tmux session $LAST_SESSION."
        else
            exec tmux new-session -s new
            echo "new tmux session created."
        fi
    fi
else
    echo "tmux is not installed. Please install tmux first."
    sleep 100
fi

exec zsh