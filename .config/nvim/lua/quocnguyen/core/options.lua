local opt = vim.opt

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

-- Others
opt.wrap = false
opt.colorcolumn = "94"

opt.scrolloff = 5

opt.virtualedit = "block"

opt.clipboard = "unnamedplus"
