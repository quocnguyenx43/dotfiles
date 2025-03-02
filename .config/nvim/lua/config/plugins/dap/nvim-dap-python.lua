return {
    "mfussenegger/nvim-dap-python",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        require("dap-python").setup("uv")
    end,
}
