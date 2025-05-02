return {
    -- LSP config
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- Close Mason-LSPconfig gap
        "williamboman/mason-lspconfig.nvim",
        -- LSP completion
        "hrsh7th/cmp-nvim-lsp",
        -- LSP for new file: Generate code for specific file
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- Config LSP for every language
        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- Capabilities
        -- local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Server configs
        -- 1. cmd {...}
        -- 2. filetypes {...}
        -- 3. capabilities {...}
        local servers = {
            -- LSP
            ast_grep = {}, -- Some files
            grammarly = {}, -- Text file
            lua_ls = { -- Lua
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            },
            bashls = {}, -- Bash
            cmake = {}, -- Cmake
            jsonls = {}, -- JSON
            lemminx = {}, -- XML
            yamlls = {}, -- YAML
            harper_ls = { -- TOML
                filetypes = { "toml" },
            },
            markdown_oxide = {}, -- Markdown
            graphql = {}, -- GraphQL
            ltex = { -- Latex
                filetypes = { "tex" },
            },
            dockerls = {}, -- Dockerfile
            docker_compose_language_service = {}, -- Docker compose 
            -- sqls = {}, -- SQL
            pyright = {}, -- Python
            jdtls = {}, -- Java

            -- Linters
            ruff = { -- Python
                commands = {
                    RuffAutofix = {
                        function()
                            vim.lsp.buf.execute_command({
                                command = "ruff.applyAutofix",
                                arguments = {
                                    { uri = vim.uri_from_bufnr(0) },
                                },
                            })
                        end,
                        description = "Ruff: Fix all auto-fixable problems",
                    },
                    RuffOrganizeImports = {
                        function()
                            vim.lsp.buf.execute_command({
                                command = "ruff.applyOrganizeImports",
                                arguments = {
                                    { uri = vim.uri_from_bufnr(0) },
                                },
                            })
                        end,
                        description = "Ruff: Format imports",
                    },
                },
            },
        }

        -- Setting all LSP up
        mason.setup()
        local handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities =
                    vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                lspconfig[server_name].setup(server)
            end,
        }
        mason_lspconfig.setup({ handlers = handlers })

        local keymap = vim.keymap
        local api = vim.api
        local lsp_group = api.nvim_create_augroup("UserLspConfig", {})

        -- Attach when LSP is loaded or enable
        api.nvim_create_autocmd("LspAttach", {
            group = lsp_group,
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                -- LSP go to
                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "Show LSP references"
                keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "Show LSP document symbols"
                keymap.set("n", "gs", "<cmd>Telescope lsp_document_symbols<CR>", opts)

                opts.desc = "Show LSP document symbols in the current workspace"
                keymap.set( "n", "gS", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)

                -- Treesitter
                opts.desc = "Show Treesitter objects"
                keymap.set( "n", "gh", "<cmd>Telescope treesitter<CR>", opts)

                -- Diagnostics
                opts.desc = "Show buffer diagnostics in the current buffer"
                keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show buffer diagnostics in the whole project"
                keymap.set("n", "<leader>dD", "<cmd>Telescope diagnostics<CR>", opts)

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts)

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev, opts)

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "<leader>dp", vim.diagnostic.goto_next, opts)

                opts.desc = "Show all code actions in the current workspace"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                -- Others
                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Smart dynammic rename variable"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })
    end,
}
