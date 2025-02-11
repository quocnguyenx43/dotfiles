-- Replace Esc with C-c
vim.api.nvim_set_keymap('n', '<C-c>', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-c>', '<Esc>', { noremap = true, silent = true })

-- Disable ZZ
vim.api.nvim_set_keymap('n', 'Z', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ZZ', '<Nop>', { noremap = true, silent = true })

-- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "T"
-- ts_repeat_move.builtin_T_expr, { expr = true })
