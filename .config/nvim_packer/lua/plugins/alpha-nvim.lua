-----------------------------------------------------------
-- Dashboard configuration file
-----------------------------------------------------------

-- Plugin: alpha-nvim
-- url: https://github.com/goolord/alpha-nvim

-- For configuration examples see: https://github.com/goolord/alpha-nvim/discussions/16


local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
  return
end

local dashboard = require('alpha.themes.dashboard')

-- Footer
local function footer()
  local version = vim.version()
  local print_version = "v" .. version.major .. '.' .. version.minor .. '.' .. version.patch
  local datetime = os.date('%Y/%m/%d %H:%M:%S')
  return print_version .. ' ' .. datetime
end

-- Banner
local prayer = {
  "Our neovim; Who art in iTerm",
  "Hallowed be thy keybinds",
  "Thy command come; thy will be done",
  "On Terminal, as it is in VSCode",
  "Give us this completion, our daily code",
  "And forgive us of using arrow keys; as we forgive those who use them against us",
  "And lead us not into IDEs; but deliver us from all mouse usage",
  "Amen"
}

dashboard.section.header.val = prayer

-- Menu
dashboard.section.buttons.val = {
  dashboard.button('n', '  New file', ':ene <BAR> startinsert<CR>'),
  dashboard.button('f', '  Search file', ':NvimTreeOpen<CR>'),
  dashboard.button('u', 'ﮮ  Update', ':PackerUpdate<CR>'),
  dashboard.button('s', '  Settings', ':e $MYVIMRC<CR>'),
  dashboard.button('q', '  Quit', ':qa<CR>'),
}

dashboard.section.footer.val = footer()

alpha.setup(dashboard.config)
