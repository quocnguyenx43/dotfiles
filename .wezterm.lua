-- Definition
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

-- Theme & font
config.color_scheme = 'Tokyo Night'
config.window_background_opacity = 0.95
config.font = wezterm.font('JetBrains Mono')
config.font_size = 11.0

-- Window & tab
config.enable_tab_bar = false
config.window_padding = {
    left = 5,
    right = 0,
    top = 10,
    bottom = 10,
}
wezterm.on("gui-startup",
    function()
        local tab, pane, window = mux.spawn_window{}
        window:gui_window():maximize()
    end
)

-- Others
config.adjust_window_size_when_changing_font_size = true
config.hide_mouse_cursor_when_typing = false

-- Key bindings
config.keys = {
    {
        key = 'c',
        mods = 'CTRL',
        action = wezterm.action_callback(
            function(window, pane)
                local has_selection = window:get_selection_text_for_pane(pane) ~= ''
                if has_selection then
                    window:perform_action(act.CopyTo 'ClipboardAndPrimarySelection', pane)
                    window:perform_action(act.ClearSelection, pane)
                else
                    window:perform_action(act.SendKey { key = 'c', mods = 'CTRL' }, pane)
                end
            end
        ),
    },
}
  
-- Startup programs
config.default_prog = {"/usr/bin/zsh", "-c", [[
    LAST_SESSION=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | tail -n 1)
    if [ -n "$LAST_SESSION" ]; then
      exec tmux attach-session -t "$LAST_SESSION"
    else
      exec tmux new-session -s new
    fi
  ]]
}

return config
