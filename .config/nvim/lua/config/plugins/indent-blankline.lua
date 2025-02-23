return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
        indent = { char = "│" },
    },
    config = function()
        local indent_blankline_augroup = vim.api.nvim_create_augroup("indent_blankline_augroup", { clear = true })

        vim.api.nvim_create_autocmd("ModeChanged", {
            group = indent_blankline_augroup,
            pattern = "[vV\x16]*:*",
            command = "IBLEnable",
            desc = "Enable indent-blankline when exiting visual mode",
        })

        vim.api.nvim_create_autocmd("ModeChanged", {
            group = indent_blankline_augroup,
            pattern = "*:[vV\x16]*",
            command = "IBLDisable",
            desc = "Disable indent-blankline when entering visual mode",
        })

        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IndentThin", { fg = "#5C6370" })
            vim.api.nvim_set_hl(0, "IndentBold", { fg = "#A0A0A0", bold = true })
        end)

        local ibl = require("ibl")
        ibl.setup({
            indent = {
                char = "│",
                highlight = "IndentThin",
            },
            scope = {
                highlight = { "IndentBold" },
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = {
                    "help",
                    "dashboard",
                    "git",
                    "terminal",
                    "txt",
                    "markdown",
                },
            },
        })

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
}
