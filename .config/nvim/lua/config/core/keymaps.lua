local keymap = vim.keymap
local api = vim.api
local g = vim.g

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = " "

local none = "<Nop>"

-- Disable ZZ
map("n", "Z", none)
map("n", "ZZ", none)

-- map("i", "<C-1>", "<ESC>^i", { desc = "move beginning of line" })
-- map("i", "<C-2>", "<End>", { desc = "move end of line" })

-- General
map("n", "<leader>c", ":nohl<CR>") -- Clear search hightlighting

-- Auto correct indentation
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Window splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>e", { desc = "Make it equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close the current window" })

-- Tab splits
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>to", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in the tab" })

-- map <F2> :retab<CR>:wq!<CR>
-- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "T"
-- ts_repeat_move.builtin_T_expr, { expr = true })
