return {
    'tamton-aquib/duck.nvim',
    lazy = true,
    keys = {
        {"<leader>dh", "<cmd>lua require('duck').hatch()<cr>"},
        {"<leader>dk", "<cmd>lua require('duck').cook()<cr>"},
        {"<leader>da", "<cmd>lua require('duck').cook_all()<cr>"},
    },
}
