return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- Formatting
                null_ls.builtins.formatting.stylua, -- Lua
                null_ls.builtins.formatting.black,  -- Python
                null_ls.builtins.formatting.isort,  -- Python
            },
        })

        local keymap = vim.keymap
        local lsp = vim.lsp

        keymap.set("n", "<leader>gf", function() lsp.buf.format() end, {})
    end,
}
