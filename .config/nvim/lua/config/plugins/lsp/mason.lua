return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_tool_installer = require("mason-tool-installer")
        local mason_lspconfig = require("mason-lspconfig")

        -- Config UI
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
                -- LSP
                "lua_ls",                          -- Lua
                "bashls",                          -- Bash script
                "cmake",                           -- Cmake
                "jsonls",                          -- JSON
                "yamlls",                          -- YAML
                "markdown_oxide",                  -- Markdown
                "docker_compose_language_service", -- Docker compose
                "dockerls",                        -- Dockerfile
                "clangd",                          -- C, C++
                "pyright",                         -- Python
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                -- DAP
                "debugpy",

                -- Linters
                "ruff", -- Python

                -- Formaters
                "stylua",   -- Lua
                "black",    -- Python
                "isort",    -- Python
                "prettier", -- FE
            },
        })
    end,
}
