local g = vim.g
local opt = vim.opt
local env = vim.env
local cmd = vim.cmd

-- General
opt.swapfile = false
opt.clipboard = "unnamedplus"

-- Change diagnostic symbols
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Disable the default file explorer
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Line number
opt.number = true
opt.relativenumber = true

-- Indent 
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true

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
if
    env.TERM == "st-256color"
    or env.TERM == "tmux-256color"
    or env.TERM == "xterm-256color"
then
    cmd("set termguicolors")
end

-- Disable default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Others
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
