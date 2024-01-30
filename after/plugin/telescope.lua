
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>gff', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.grep_string, {})

-- $env:Path += ";$(Get-Location)"
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, {})

local actions = require "telescope.actions"

require("telescope").setup {
    defaults = {
        -- ....
    },
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
}
