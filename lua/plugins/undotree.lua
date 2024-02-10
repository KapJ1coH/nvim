return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set('n', '<leader>u', ":UndotreeToggle<CR> <BAR> :UndotreeFocus<CR>")
    end,
    lazy = false,
}

