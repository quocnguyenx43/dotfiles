return {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = function ()
        local surround = require("nvim-surround")
        surround.setup()
    end,
}
