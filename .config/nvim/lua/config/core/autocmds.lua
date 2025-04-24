local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- -- Format on modified
-- local format_on_modified = augroup("FormatOnModified", { clear = true })
-- autocmd("BufModifiedSet", {
--     group = format_on_modified,
--     callback = function()
--         pcall(function()
--             -- Format buffer with LSP
--             vim.lsp.buf.format()
--             -- Remove trailing spaces
--             vim.cmd("%s/\\s\\+$//e")
--         end)
--     end,
--     desc = "Format on buffer modification",
-- })
        -- TODO
        -- Always opening NvimTree
        -- vim.api.nvim_create_autocmd("BufReadPost", {
        --     callback = function()
        --         local api = require("nvim-tree.api")

        --         -- Open the tree (but don't focus it)
        --         api.tree.open({ focus = false })

        --         -- Reveal and highlight the current file in the tree
        --         api.tree.find_file({ open = true, focus = false })
        --     end,
        -- })
