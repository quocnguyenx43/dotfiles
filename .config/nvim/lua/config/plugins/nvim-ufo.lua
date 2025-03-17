return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
        -- Using Treesitter for folding range
        local ufo = require("ufo")
        ufo.setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        })

        vim.keymap.set("n", "zR", require("ufo").openAllFolds)
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
        vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
        vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
        vim.keymap.set("n", "zK", function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
                -- choose one of coc.nvim and nvim lsp
                vim.fn.CocActionAsync("definitionHover") -- coc.nvim
                vim.lsp.buf.hover()
            end
        end)
    end,
}
