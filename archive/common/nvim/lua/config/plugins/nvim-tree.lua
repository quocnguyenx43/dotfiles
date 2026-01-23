return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local nvimtree = require("nvim-tree")

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

        keymap.set( "n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree: Toggle file explorer" })
        keymap.set( "n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "NvimTree: Collapse the current file" })
        keymap.set( "n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "NvimTree: Collapse file explorer" })
        keymap.set( "n", "<leader>ek", "<cmd>NvimTreeCollapseKeepBuffers<CR>", { desc = "NvimTree: Collapse all but keep the current buffers" })
        keymap.set( "n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "NvimTree: Refresh file explorer" })

        -- Always opening NvimTree
        vim.api.nvim_create_autocmd("BufReadPost", {
            callback = function()
                local api = require("nvim-tree.api")
                -- Open NvimTree and focus on the file
                api.tree.find_file({ open = true, focus = false })
            end,
        })
    end,
}
