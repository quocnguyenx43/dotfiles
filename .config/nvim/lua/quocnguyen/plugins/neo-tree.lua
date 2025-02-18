return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local neotree = require("neo-tree")
        neotree.setup()

        local fn = vim.fn
        fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
        fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
        fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
        fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

        local keymap = vim.keymap
		keymap.set("n", "<leader>ee", ":Neotree filesystem reveal left<CR>", { desc = "Open Neotree file explorer" })
		keymap.set("n", "<leader>eq", ":Neotree filesystem close <CR>", { desc = "Close Neotree file explore" })
		keymap.set("n", "<leader>er", ":Neotree reveal <CR>", { desc = "Reveal Neotree current file" })
	end,
}
