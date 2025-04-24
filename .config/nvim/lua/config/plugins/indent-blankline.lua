return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
        local ibl = require("ibl")
        local hooks = require("ibl.hooks")
        local highlight = {
            "IndentLineWhite",
            "IndentLineWhiteScope",
        }

        -- Add colour to hooks
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IndentLineWhite", { fg = "#677176", bold = false })
            vim.api.nvim_set_hl(0, "IndentLineWhiteScope", { fg = "#677176", bold = true })
        end)

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        vim.g.rainbow_delimiters = { highlight = highlight }
        ibl.setup({ indent = { char = "┊" }, scope = { char = "│", highlight = highlight }, })
    end,
}
