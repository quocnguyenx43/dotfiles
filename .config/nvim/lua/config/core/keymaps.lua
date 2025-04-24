local keymap = vim.keymap
local api = vim.api
local g = vim.g
local none = "<Nop>"

-- Mapping function
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Leader key
g.mapleader = " "
g.maplocalleader = " "

-- Disable spacebar to other behaviors
keymap.set({ 'n', 'v' }, '<Space>', none, { silent = true })

-- Disable ZZ
map("n", "Z", none)
map("n", "ZZ", none)

-- Clear search hightlighting
map("n", "<leader>c", ":nohl<CR>")

-- Delete character without copying into register
map(
    "n",
    "x",
    '"_x',
    { desc = "Delete forward single character without copying into register" }
)
map(
    "n",
    "X",
    '"_X',
    { desc = "Delete backward single character without copying into register" }
)

-- HOME & END
map("i", "<C-b>", "<Home>", { desc = "Move to the beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move to the end of line" })

-- Auto correct indentation
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move up" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move down" })

-- Window resize
-- vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
-- vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
-- vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]])
-- vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])

-- Window splits
keymap.set("n", "<leadxr>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>e", { desc = "Make it equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close the current window" })

-- Tab splits
keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set(
    "n",
    "<leader>tf",
    "<cmd>tabnew %<CR>",
    { desc = "Open current buffer in the tab" }
)

-- map <F2> :retab<CR>:wq!<CR>
-- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "T"
-- ts_repeat_move.builtin_T_expr, { expr = true })
