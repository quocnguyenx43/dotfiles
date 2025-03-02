return {
    "L3MON4D3/LuaSnip",
    lazy = false,
    dependencies = {
        "rafamadriz/friendly-snippets",
        "cstrap/python-snippets",
    },
    config = function()
        -- Using VSCode snippets
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
