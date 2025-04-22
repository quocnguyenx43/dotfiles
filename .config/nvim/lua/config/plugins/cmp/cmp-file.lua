return {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
    },
    config = function() end,
    require("lsp-file-operations").setup({
        debug = false,
        operations = {
            willRenameFiles = true,
            didRenameFiles = true,
            willCreateFiles = true,
            didCreateFiles = true,
            willDeleteFiles = true,
            didDeleteFiles = true,
        },
        timeout_ms = 10000,
    }),
}
