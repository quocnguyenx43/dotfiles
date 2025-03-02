return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.add({
            {
                mode = { "n", "v" },
                { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
                { "<leader>w", "<cmd>w<cr>", desc = "Write" },
            },
            { "<leader>f", desc = "Find/files" },
        })
    end,
}
