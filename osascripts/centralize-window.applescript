on run {screen_width, screen_height}
    set w to (screen_width / 5) * 3
    set h to (screen_height / 5) * 3
    set x to (screen_width - w) / 2
    set y to (screen_height - h) / 2

    tell application "System Events"
        tell first application process whose frontmost is true
            set position of first window to {x, y}
            set position of last window to {x, y}
            set size of first window to {w, h}
            set size of last window to {w, h}
        end tell
    end tell
end run