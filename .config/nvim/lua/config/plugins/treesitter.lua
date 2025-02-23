return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {
                "vim",
                "lua",
                "json",
                "markdown",
                "markdown_inline",
                "bash",
                "dockerfile",
                "regex",
                "xml",
                "yaml",
                "c",
                "cpp",
                "java",
                "python",
                "scala",
                "sql",
                "scala",
                "javascript",
            },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Leader>ss",
                    node_incremental = "<Leader>si",
                    node_decremental = "<Leader>sd",
                    scope_incremental = "<Leader>sc",
                },
            },
        })
    end,
}
