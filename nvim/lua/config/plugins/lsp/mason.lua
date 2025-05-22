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
                "ast_grep", -- For C#, C/C++, HTML, CSS, JavaScript, Go, Java, Rust
                "grammarly", -- Text
                "lua_ls", -- Lua
                "bashls", -- Bash script
                "cmake", -- Cmake
                "jsonls", -- JSON
                "lemminx", -- XML
                "yamlls", -- YAML
                "harper_ls", -- TOML
                "markdown_oxide", -- Markdown
                "graphql", -- GraphQL
                "ltex", -- Latex
                "dockerls", -- Dockerfile
                "docker_compose_language_service", -- Docker compose
                -- "sqls", -- SQL
                "clangd", -- C, C++
                "pyright", -- Python
                "jdtls", -- Java
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                -- DAP
                "debugpy",

                -- Linters
                "ruff", -- Python

                -- Formaters
                "stylua", -- Lua
                "black", -- Python
                "isort", -- Python
                "prettier", -- FE
            },
        })
    end,
}
