return {
    -- UI
    'mhinz/vim-startify',


    -- Treesitter and Lsp stuff
    'mbbill/undotree',

    -- Text fuckery
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    'ixru/nvim-markdown',
}
