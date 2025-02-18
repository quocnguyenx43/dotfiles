return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = { 
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    }
                }
            }
        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Telescope fuzzy find files" })
        keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Telescope fuzzy find old files" })
        keymap.set("n", "<leader>fl", "<cmd> Telescope live_grep <CR>", { desc = "Telescope live grep" })
        keymap.set("n", "<leader>fs", "<cmd> Telescope grep_string <CR>", { desc = "Telescope grep string" })
        keymap.set("n", "<leader>fg", "<cmd> Telescope git_files <CR>", { desc = "Telescope git files finders" })
        keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Telescope buffers finders" })
    end,
}
