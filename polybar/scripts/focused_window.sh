#!/bin/bash

# Get active window ID
active_window_id=$(xdotool getactivewindow)

# Get the WM_CLASS (application identifier)
win_class=$(xprop -id "$active_window_id" WM_CLASS 2>/dev/null | awk -F '"' '{print $4}')

# Get the window title (usually contains file or directory info)
win_title=$(xprop -id "$active_window_id" _NET_WM_NAME 2>/dev/null | sed -n 's/.*"\(.*\)"/\1/p')

# Output logic
case "$win_class" in
    "code" | "Code")
        dir=$(echo "$win_title" | awk -F ' - ' '{print $(NF-1)}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        echo "Code ($dir)"
        ;;
    "nautilus" | "org.gnome.Nautilus")
        dir=$(echo "$win_title" | awk -F ' - ' '{print $(NF-1)}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        echo "Nautilus ($dir)"
        ;;
    "Thunar" | "thunar")
        dir=$(echo "$win_title" | awk -F ' - ' '{print $(NF-1)}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        echo "Thunar ($dir)"
        ;;
    "Dolphin" | "dolphin")
        dir=$(echo "$win_title" | awk -F ' - ' '{print $(NF-1)}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        echo "Dolphin ($dir)"
        ;;
    *)
        echo "$win_class"
        ;;
esac
