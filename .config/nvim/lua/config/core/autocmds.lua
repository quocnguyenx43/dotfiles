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
