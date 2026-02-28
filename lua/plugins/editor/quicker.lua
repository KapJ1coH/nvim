return {
    'stevearc/quicker.nvim',
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    keys = {
        {
            "<leader>qt",
            function()
                require("quicker").toggle()
            end,
            desc = "Toggle quickfix",
        },
        {
            "<leader>ql",
            function()
                require("quicker").toggle({ loclist = true })
            end,
            desc = "Toggle loclist",
        },
        {
            "<leader>>",
            function()
                require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
        },
        {
            "<leader><",
            function()
                require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
        },
    },
}
