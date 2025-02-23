return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local nvimtree = require("nvim-tree")

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({
            view = {
                number = true,
                relativenumber = true,
                width = 35,
            },
            renderer = {
                highlight_opened_files = "icon",
                highlight_diagnostics = "icon",
                highlight_modified = "icon",
                indent_markers = {
                    enable = true,
                },
            },
            diagnostics = {
                enable = true,
            },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree: Toggle file explorer" })
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "NvimTree: Collapse file explorer" })
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "NvimTree: Refresh file explorer" })
    end,
}
