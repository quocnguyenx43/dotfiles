local g = vim.g
local opt = vim.opt
local env = vim.env
local cmd = vim.cmd

-- General
opt.swapfile = false

-- Line number
opt.number = true
opt.relativenumber = true

-- Tab size
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"
opt.hlsearch = true
opt.incsearch = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Colors
opt.termguicolors = true
if env.TERM == "st-256color" or env.TERM == "tmux-256color" or env.TERM == "xterm-256color" then
    cmd("set termguicolors")
end

-- Others
opt.autoindent = true
opt.smartindent = true
opt.virtualedit = "block"

opt.wrap = false
opt.colorcolumn = "94"
opt.scrolloff = 5
opt.fillchars:append({
    vert = "┃",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
})
opt.clipboard = "unnamedplus"

opt.showmatch = true
opt.matchtime = 3

