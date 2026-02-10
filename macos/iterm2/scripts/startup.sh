#!/bin/zsh

# Fix colors on MacOS
if [[ "$OS" == "macos" ]]; then
    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
    export TERM=wezterm
else
    export PATH="/usr/local/bin:$PATH"
fi

TMUX_BIN="$(command -v tmux)"

if [ -z "$TMUX" ] && [ -n "$TMUX_BIN" ]; then
    LAST_SESSION=$($TMUX_BIN list-sessions -F "#{session_name}" 2>/dev/null | head -n 1)
    if [ -n "$LAST_SESSION" ]; then
        exec $TMUX_BIN attach-session -t "$LAST_SESSION" \;\
            set-option display-time 10000 \;\
            display-message "🐧 Get back to session '$LAST_SESSION'"
    else
        $TMUX_BIN new-session -d -s new-session
        exec $TMUX_BIN attach-session -t new-session \;\
            set-option display-time 10000 \;\
            display-message "🐧 New tmux session started!"
    fi
fi

exec zsh
