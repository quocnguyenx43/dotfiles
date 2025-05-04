#!/bin/bash

if [ -z "$TMUX" ]; then
    LAST_SESSION=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | tail -n 1)
    if [ -n "$LAST_SESSION" ]; then
        tmux attach-session -t "$LAST_SESSION"
    else
        tmux new-session -s new
    fi
fi

exec zsh