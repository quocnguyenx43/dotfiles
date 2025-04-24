return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                mode = "tabs", -- Showing tabpages
                diagnostics = "nvim_lsp", -- Diagnostics using
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        seperator = true,
                    },
                    hover = {
                        enabled = true,
                        delay = 150,
                        reveal = { "close" },
                    },
                },
                -- Custom function for display diagnostics
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    -- Only showing diagnostics on the current buffer
                    if context.buffer:current() then
                        return ""
                    end

                    -- Icons to display based on diagnostic level
                    local diagnostic_icons = { error = " ", warning = " ", info = " ", hint = " " }

                    if level:match("error") then
                        return " " .. diagnostic_icons.error .. count
                    elseif level:match("warning") then
                        return " " .. diagnostic_icons.warning .. count
                    elseif level:match("info") then
                        return " " .. diagnostic_icons.info .. count
                    elseif level:match("hint") then
                        return " " .. diagnostic_icons.hint .. count
                    end

                    return ""
                end,
                -- Custom function for no showing unwanted buffer types, file types
                custom_filter = function(buf_number)
                    local buftype = vim.bo[buf_number].buftype
                    local filetype = vim.bo[buf_number].filetype
                    local bufname = vim.fn.bufname(buf_number)

                    -- Ignore: terminal, nofile, or quickfix
                    if
                        buftype == "nofile"
                        or buftype == "terminal"
                        or buftype == "quickfix"
                    then
                        return false
                    end

                    -- Ignore unnamed buffer
                    if bufname == "" then
                        return false
                    end

                    -- Ignore file types
                    local ignored_filetypes = {
                        "NvimTree",
                        "oil",
                        "toggleterm",
                        "neo-tree",
                        "Outline",
                        "help",
                        "qf",
                        "gitcommit",
                    }

                    for _, ft in ipairs(ignored_filetypes) do
                        if filetype == ft then
                            return false
                        end
                    end

                    return true
                end,
            },
        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>")
        keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>")
        keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>")
        keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>")
        keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>")
        keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>")
        keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>")
        keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>")
        keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>")
        keymap.set("n", "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>")
    end,
}
