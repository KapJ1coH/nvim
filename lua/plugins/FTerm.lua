-- vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
-- vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

return {
    "numToStr/FTerm.nvim",
    opts = {
        cmd = "pwsh",
        border     = 'double',
        dimensions = {
            height = 0.9,
            width = 0.9,
        },
    },
    keys = {
        {
            '<leader>ct',
            mode = "n",
            function ()
                require("FTerm").toggle()
            end
        },
        {
            '<leader>ct',
            mode = "t",
            function ()
                require("FTerm").toggle()
            end
        },
    }
}
