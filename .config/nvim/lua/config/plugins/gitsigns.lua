return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 0,
            }
        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>gv", "<CMD>Gitsigns preview_hunk_inline<CR>", { desc = "Git preview hunk inline" })
        keymap.set("n", "<leader>gs", "<CMD>Gitsigns select_hunk<CR>", { desc = "Git select hunk" })
        keymap.set("n", "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "Git reset hunk inline" })
        keymap.set("n", "<leader>gn", "<CMD>Gitsigns nav_hunk next<CR>", { desc = "Git next hunk" })
        keymap.set("n", "<leader>gp", "<CMD>Gitsigns nav_hunk prev<CR>", { desc = "Git prev hunk" })
        keymap.set("n", "<leader>gq", "<CMD>Gitsigns setloclist target=attached<CR>", { desc = "Git quickfix list for current buffer" })
        keymap.set("n", "<leader>gQ", "<CMD>Gitsigns setloclist target=all<CR>", { desc = "Git quickfix list for whole workspace" })
    end,
}
