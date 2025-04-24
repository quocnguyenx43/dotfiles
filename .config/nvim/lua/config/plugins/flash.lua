return {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
        local flash = require("flash")

        flash.setup({
            modes = {
                char = {
                    jump_labels = true,
                },
            },
        })

        local keymap = vim.keymap.set
        keymap({ "n", "x", "o" }, "<leader>ls", flash.jump, { desc = "Flash" })
        keymap({ "n", "x", "o" }, "<leader>lt", flash.treesitter, { desc = "Flash Treesitter" })
        keymap("o", "<leader>lr", flash.remote, { desc = "Remote Flash" })
        keymap({ "o", "x" }, "<leader>la", flash.treesitter_search, { desc = "Flash Treesitter search" })
        keymap("c", "<c-s>", flash.toggle, { desc = "Toggle Flash Search" })
    end,
}

