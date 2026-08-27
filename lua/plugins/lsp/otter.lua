return {

    {
        'jmbuhr/otter.nvim',
        dependencies = {
            'neovim-treesitter/nvim-treesitter',
        },
        opts = {},
    },
    {
        'neovim-treesitter/nvim-treesitter',
        dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
        lazy = false,
        build = ':TSUpdate',
    }
}
