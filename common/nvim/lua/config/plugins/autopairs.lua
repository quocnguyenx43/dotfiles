return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local autopairs = require("nvim-autopairs")

        -- Setup and disable on prompts, panel and txt files
        autopairs.setup({
            check_ts = true,
            disable_filetype = { "TelescopePrompt", "spectre_panel", "txt" },
        })

        -- Config for autopairs completion
        local cmp = require("cmp")
        local autopairs_cmp = require("nvim-autopairs.completion.cmp")
        local autopairs_handlers = require("nvim-autopairs.completion.handlers")
        cmp.event:on(
            "confirm_done",
            autopairs_cmp.on_confirm_done({
                filetypes = {
                    ["*"] = {
                        ["("] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method,
                            },
                            handler = autopairs_handlers["*"],
                        },
                    },
                    tex = false,
                },
            })
        )
    end,
}
