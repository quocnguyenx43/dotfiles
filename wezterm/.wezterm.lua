-- Definition
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

-- Theme & font
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.98
config.font = wezterm.font_with_fallback(
    {
        "JetBrains Mono NL",
        'JetBrains Mono',
        'FiraCode Nerd Font',
        'Menlo',
    }
)
config.font_size = 14

-- Window & tab
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_padding = {
    left = 5,
    right = 0,
    top = 10,
    bottom = 10,
}

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window({})
    window:gui_window():set_inner_size(1280, 720)
end)


-- Keybindings
config.keys = {
}

-- Others
config.adjust_window_size_when_changing_font_size = true
config.hide_mouse_cursor_when_typing = false

return config