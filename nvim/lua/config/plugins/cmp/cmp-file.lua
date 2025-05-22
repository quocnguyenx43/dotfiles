return {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
    },
    config = function()
        local lsp_file_ops = require("lsp-file-operations")
        lsp_file_ops.setup({
            debug = false,
            operations = {
                willRenameFiles = true,
                didRenameFiles = true,
                willCreateFiles = true,
                didCreateFiles = true,
                willDeleteFiles = true,
                didDeleteFiles = true,
            },
            timeout_ms = 10000,
        })


        local lspconfig = require 'lspconfig'
        -- Set global defaults for all servers
        lspconfig.util.default_config = vim.tbl_extend(
            'force',
            lspconfig.util.default_config,
            {
                capabilities = vim.tbl_deep_extend(
                    "force",
                    vim.lsp.protocol.make_client_capabilities(),
                    -- returns configured operations if setup() was already called
                    -- or default operations if not
                    require 'lsp-file-operations'.default_capabilities()
                )
            }
        )
    end,
}
