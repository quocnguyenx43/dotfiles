#!/bin/bash

export DISPLAY=:0

# Get the currently focused workspace
current_ws=$(wmctrl -d | awk '$2 == "*" {print $1}')

# Get all window IDs with info
active_win=$(xdotool getactivewindow)
active_win_hex=$(printf "0x%08x\n" "$active_win")

wmctrl -lpx | awk -v ws="$current_ws" -v active="$active_win_hex" '
{
    win_id = $1
    desk = $2
    pid = $3
    wm_class = $4
    title_start = index($0, $5)
    title = substr($0, title_start)

    if (desk != ws) next

    app = ""
    dir = ""

    # Match common apps
    if (wm_class ~ /code/i) {
        app = "Code"
        if (match(title, / - ([^\/]+\/[^\/]+)$/)) {
            dir = substr(title, RSTART + 3, RLENGTH - 3)
        }
    } else if (wm_class ~ /firefox/i) {
        app = "Firefox"
    } else if (wm_class ~ /nautilus|org.gnome.Nautilus|thunar/i) {
        app = "Files"
        if (match(title, /([^\/]+) - Files/)) {
            dir = substr(title, RSTART, RLENGTH - 7)
        }
    } else {
        app = title
    }

    # Format output
    output = app
    if (dir != "") {
        output = output " (" dir ")"
    }

    # Highlight active
    if (win_id == active) {
        output = "%{u#ffa000+u}%{+o}" output "%{-u -o}"
    }

    print output
}' | paste -sd ' | ' -
