return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {},
    config = function()
        local comment = require("Comment")
        comment.setup({
            -- Ignore empty line, dont comment empty line
            ignore = "^$",
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
    end,
}
