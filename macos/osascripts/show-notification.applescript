on run argv
    if (count of argv) > 0 then
        set messageText to item 1 of argv
    else
        set messageText to "Default Notification"
    end if

    if (count of argv) > 1 then
        set titleText to item 2 of argv
    else
        set titleText to "🚀 Custom Notification"
    end if

    display notification messageText with title titleText
end run