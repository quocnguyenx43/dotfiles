on run argv
    if (count of argv) > 0 then
        set messageText to item 1 of argv
    else
        set messageText to "Default Notification"
    end if

    display notification messageText with title "🚀 Custom Notification"
end run