-- Definition
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

-- OS Detection
local os_name = wezterm.target_triple
local is_macos = os_name:find("darwin") ~= nil
local is_linux = os_name:find("linux") ~= nil

-- Default values (can be overridden)
local shell = "/bin/sh"
local font_size = 12
local window_decorations = "RESIZE"
local width = 1280
local height = 720
local maximize = true

if is_macos then
    shell = "/bin/zsh"
    font_size = 14
    window_decorations = "NONE"
    width = 1280
    height = 720
    maximize = false
elseif is_linux then
    shell = "/usr/bin/zsh"
    font_size = 10
    window_decorations = "TITLE | RESIZE"
    width = 1600
    height = 900
    maximize = true
end

-- Theme & font
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback(
    {
        "JetBrains Mono NL",
        'JetBrains Mono',
        'FiraCode Nerd Font',
        'Menlo',
    }
)
config.font_size = font_size

-- Window & tab
config.enable_tab_bar = false
-- config.window_decorations = window_decorations
config.window_padding = {
    left = 5,
    right = 0,
    top = 10,
    bottom = 10,
}

-- Never show close confirmation dialog
config.window_close_confirmation = 'AlwaysPrompt'

-- Set the size of the window
if maximize then
    wezterm.on("gui-startup", function()
        local tab, pane, window = mux.spawn_window({})
        window:gui_window():maximize()
    end)
else
    wezterm.on("gui-startup", function()
        local tab, pane, window = mux.spawn_window({})
        window:gui_window():set_inner_size(width, height)
    end)
end

-- Keybindings
config.keys = {
    {
        key = "LeftArrow",
        mods = "ALT",
        action = wezterm.action.SendString("\x1bb"),
    },
    {
        key = "RightArrow",
        mods = "ALT",
        action = wezterm.action.SendString("\x1bf"),
    },
    {
        key = "Backspace",
        mods = "ALT",
        action = wezterm.action.SendString("\x1b\x7f"),
    },
}

-- Default program
config.default_prog = { "/bin/zsh", "-c", "exec ./.wezterm_startup.sh" }

-- Others
config.adjust_window_size_when_changing_font_size = true
config.hide_mouse_cursor_when_typing = false

return config