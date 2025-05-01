-- Definition
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

-- Theme & font
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.98
-- https://github.com/podkovyrin/JetBrainsMono/tree/feature/no-ligatures-1-0-3/no-ligatures
config.font = wezterm.font_with_fallback(
	{
		"JetBrains Mono NL",
		'JetBrains Mono',
		'FiraCode Nerd Font',
		'Menlo',
	}
)
config.font_size = 11

-- Window & tab
config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"
config.window_padding = {
	left = 5,
	right = 0,
	top = 10,
	bottom = 10,
}

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- -- Others
config.adjust_window_size_when_changing_font_size = true
config.hide_mouse_cursor_when_typing = false

return config