on run argv
    if (count of argv) > 0 then
        set width_adjustment to item 1 of argv
        set height_adjustment to item 2 of argv
    else
        set width_adjustment to 0
        set height_adjustment to 0
    end if

    tell application "System Events"
        set _app to name of first application process whose frontmost is true
        tell process _app
            set _window to front window
            set {x, y, window_width, window_height} to _window's position & _window's size
            set position of _window to {x - (width_adjustment / 2), y - (height_adjustment / 2)}
            set size of _window to {window_width + width_adjustment, window_height + height_adjustment}
            activate
        end tell
    end tell
end run
