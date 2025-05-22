local fn = vim.fn
local api = vim.api
local loop = vim.loop
local uv = vim.uv
local v = vim.v
local opt = vim.opt

-- Setup lazy.nvim
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (uv or loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if v.shell_error ~= 0 then
        api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        fn.getchar()
        os.exit(1)
    end
end

opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "config.plugins" },
        { import = "config.plugins.lsp" },
        { import = "config.plugins.dap" },
        { import = "config.plugins.cmp" },
    },
    defaults = {
        lazy = false,
        version = false,
    },
    install = { colorscheme = { "tokyonight" } },
    checker = {
        enabled = true,
        notify = false,
    },
    change_direction = {
        notify = false,
    },
})
