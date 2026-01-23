return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local noice = require("noice")

        noice.setup({
            lsp = {
                -- Best highlighting
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                long_message_to_split = false,
            },
            -- Display CMDs and popupmenu together
            views = {
                cmdline_popup = {
                    position = {
                        row = 5,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "single",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        })


        local function noice_cmd(cmd)
            return function()
                require("noice").cmd(cmd)
            end
        end

        local keymap = vim.keymap
        keymap.set("n", "<leader>nd", noice_cmd("dismiss"), { desc = "Noice dismiss message" })
        keymap.set("n", "<leader>nl", noice_cmd("last"), { desc = "Noice last message" })
        keymap.set("n", "<leader>ne", noice_cmd("errors"), { desc = "Noice error message" })
    end,
}
