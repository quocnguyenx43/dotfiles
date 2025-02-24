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

        -- local hooks = require("ibl.hooks")
        -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        --     vim.api.nvim_set_hl(0, "IndentThin", { fg = "#5C6370" })
        --     vim.api.nvim_set_hl(0, "IndentBold", { fg = "#A0A0A0", bold = true })
        -- end)
        --
        -- local ibl = require("ibl")
        -- ibl.setup({
        --     indent = {
        --         char = "│",
        --         highlight = "IndentThin",
        --     },
        --     scope = {
        --         enabled = true,
        --         highlight = { "IndentBold" },
        --         show_start = false,
        --         show_end = false,
        --     },
        --     exclude = {
        --         filetypes = {
        --             "help",
        --             "dashboard",
        --             "git",
        --             "terminal",
        --             "txt",
        --             "markdown",
        --         },
        --     },
        -- })
        --
        -- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }
        local hooks = require("ibl.hooks")
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)

        vim.g.rainbow_delimiters = { highlight = highlight }
        require("ibl").setup({ scope = { highlight = highlight } })

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
}
