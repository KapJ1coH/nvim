local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

return{

    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require("harpoon").setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 40,
            }
        })
    end,
    keys = {
        {'<leader>a', mark.add_file},
        {'<C-e>', ui.toggle_quick_menu},

        {'<C-h>', function() ui.nav_file(1) end},
        {'<C-t>', function() ui.nav_file(2) end},
        {'<C-s>', function() ui.nav_file(3) end},
        {'<C-n>', function() ui.nav_file(4) end},
    },
}
