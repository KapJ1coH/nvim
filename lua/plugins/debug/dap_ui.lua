return {
    "rcarriga/nvim-dap-ui",
    condition = {
        filetype = { "py" },
    },
    dependencies = { "mfussenegger/nvim-dap-python", "nvim-neotest/nvim-nio" },
    config = function()
        require("lazydev").setup({
            library = { "nvim-dap-ui" },
        })
        require("dapui").setup()
    end,
}
