return {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require("harpoon"):setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 40,
            }
        })
    end,
    keys = {
        { "<leader>a", function() require("harpoon"):list():append() end,  desc = "harpoon file", },
        {
            '<C-e>',
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "harpoon quick menu",
        },
        { '<C-h>',     function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
        { '<C-t>',     function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
        { '<C-s>',     function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
        { '<C-n>',     function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
    },
}
