return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "folke/tokyonight.nvim", 
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("nvim-tree").setup {}
        vim.keymap.set('n', '<leader>t', ":NvimTreeFindFileToggle<CR>")
        -- vim.keymap.set('n', '<leader>t', ":NvimTreeFindFileToggle<CR> <BAR> :NvimTreeFocus<CR>")
    end,

}
