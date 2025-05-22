on run argv
    if (count of argv) > 1 then
        set deltaX to item 1 of argv as integer
        set deltaY to item 2 of argv as integer
    else
        set deltaX to 0
        set deltaY to 0
    end if

    tell application "System Events"
        set _app to name of first application process whose frontmost is true
        tell process _app
            set _window to front window
            set {x, y} to position of _window
            set newX to x + deltaX
            set newY to y + deltaY
            set position of _window to {newX, newY}
        end tell
    end tell
end run
