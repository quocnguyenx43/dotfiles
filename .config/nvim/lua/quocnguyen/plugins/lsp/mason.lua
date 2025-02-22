return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            ensure_installed = {
                -- "bashls",
                -- "docker_compose_language_service",
                -- "clangd",
                "lua_ls",
                "pyright",
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                -- "prettier",
                "stylua",
                -- "isort",
                -- "black",
                -- "pylint",
                -- "eslint_d",
            },
        })

        -- ignore diagnostic neo tree
        -- https://github.com/neovim/neovim/pull/26927
        local config = {
            update_in_insert = true,
        }

        vim.diagnostic.config(config)
    end,
}
