return {
    "hrsh7th/cmp-cmdline",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local cmp = require("cmp")

        -- Using buffer source for searching
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Using path source for COMMAND mode
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })
    end,
}
