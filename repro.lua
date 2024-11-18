vim.env.LAZY_STDPATH = ".repro"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

require("lazy.minit").repro({
    spec = {
        {
            "folke/snacks.nvim",
            priority = 1000,
            lazy = false,
            opts = {
                dashboard = { enabled = true },
            }
        },
        -- add any other plugins here
    },
})
