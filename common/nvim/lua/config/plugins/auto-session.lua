return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_restore_enabled = true,
            auto_session_suppress_dirs = {
                "~/",
                "~/Desktop",
                "~/Documents",
                "~/Downloads",
                "~/Music",
                "~/Pictures",
                "~/Public",
                "~/Templates",
                "~/Videos",
            },
            -- Disable only the dashboard is open
            bypass_save_filetypes = { 'alpha', 'dashboard' }
        })

        local keymap = vim.keymap
        keymap.set( "n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
        keymap.set( "n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for cwd" })
    end,
}
