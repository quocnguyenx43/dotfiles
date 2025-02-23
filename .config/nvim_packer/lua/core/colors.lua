-----------------------------------------------------------

-- Color schemes configuration file
-----------------------------------------------------------


-- Load nvim color scheme:
-- Change the "require" values with your color scheme
-- Available color schemes: onedark, monokai, rose-pine
local status_ok, color_scheme = pcall(require, 'catppuccin')
if not status_ok then
  return
end

-- OneDark styles: dark, darker, cool, deep, warm, warmer, light
require('catppuccin').setup()

local M = {}

M.catppuccin = {
  bg = '24273a',
  fg = 'cad3f5',
  pink = 'f5bde6',
  green = 'a6da95',
  cyan = '91d7e3',
  yellow = 'eed49f',
  orange = 'f5a97f',
  red = 'ed8796'
}
return M

