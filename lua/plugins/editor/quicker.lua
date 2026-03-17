return {
    {
        'stevearc/quicker.nvim',
        ft = "qf",
        -- dependencies = {'yorickpeterse/nvim-pqf'},
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
            -- jump to next / prev item in quickfix
            { "<leader>qn", "<cmd>cnext<CR>",  desc = "Next quickfix item" },
            { "<leader>qp", "<cmd>cprev<CR>",  desc = "Previous quickfix item" },

            -- jump to first / last
            { "<leader>qf", "<cmd>cfirst<CR>", desc = "First quickfix item" },
            { "<leader>qa", "<cmd>clast<CR>",  desc = "Last quickfix item" },

            -- close quickfix manually
            { "<leader>qc", "<cmd>cclose<CR>", desc = "Close quickfix list" },

        },
    },
    -- {
    --     'kevinhwang91/nvim-bqf',
    --     dependencies = { 'junegunn/fzf' },
    -- },
}
