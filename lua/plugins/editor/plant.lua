return {
    'https://gitlab.com/itaranto/plantuml.nvim',
    version = '*',
    config = function()
        require('plantuml').setup(
            {
                renderer = {
                    type = 'image',
                    options = {
                        prog = 'imv',
                        dark_mode = true,
                        format = 'png', -- Allowed values: nil, 'png', 'svg'.
                    }
                },
                render_on_write = true,
            }

        )
    end,
    keys = {
        {
            '<leader>pu',
            "<cmd>PlantUML<cr>",
            desc = 'Render PlantUML diagram',
        },
    },

}
