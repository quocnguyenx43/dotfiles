return {
    "nvim-treesitter/nvim-treesitter",
    -- Always update the latest parser
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local treesitter_config = require("nvim-treesitter.configs")
        treesitter_config.setup({
            ensure_installed = {
                -- 1. Vim
                "vim",
                "vimdoc",
                "lua",
                "luadoc",
                -- 2. Git
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitignore",
                -- 3. Common
                "json",
                "json5",
                "jsonc",
                "jsonnet",
                "csv",
                "tsv",
                "regex",
                "yaml",
                "markdown",
                "markdown_inline",
                "bibtex",
                -- "latex",
                -- 4. FE
                "xml",
                "html",
                -- 5. Config
                "ssh_config",
                "nginx",
                "tmux",
                -- Programming
                "bash",
                "matlab",
                "dockerfile",
                "make",
                "cmake",
                -- "sql",
                "c",
                "cpp",
                "java",
                -- "javadoc",
                "scala",
                "python",
                "r",
                "javascript",
            },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true, disable = { "txt" } },
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
