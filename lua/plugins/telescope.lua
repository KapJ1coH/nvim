local builtin = require('telescope.builtin')
local actions = require "telescope.actions"

return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        pickers = {
            find_files = {
                find_command = { "fd" }
            },
        },
        buffers = {
            mappings = {
                i = {
                    ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                }
            }
        }
    },
    keys = {
        { '<leader>ff',  builtin.find_files,  {} },
        { '<leader>lg',  builtin.live_grep,   {} },
        { '<leader>fb',  builtin.buffers,     {} },
        { '<leader>fh',  builtin.help_tags,   {} },
        { '<leader>gff', builtin.git_files,   {} },
        { '<leader>fg',  builtin.grep_string, {} },

        -- $env:Path += ";$(Get-Location)"
        { '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end,
        },

    },
}
