local username = vim.fn.expand('$USER')
if username == '$USER' then
    username = vim.fn.expand('$USERNAME')
end

if username == 'ty096829' then
    return {
        'zbirenbaum/copilot.lua',
        lazy = false,
        enabled = false,
    }
end
local keys = {
    { "<leader>ce", "<cmd>Copilot enable<CR>" },
    { "<leader>cd", "<cmd>Copilot disable<CR>" },
    { "<leader>cp", "<cmd>Copilot panel<CR>" },

}



return {
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        -- enabled = false,
        event = 'InsertEnter',
        opts = {
            suggestion = {
                auto_trigger = true,
                -- Use alt to interact with Copilot.
                keymap = {
                    -- Disable the built-in mapping, we'll configure it in nvim-cmp.
                    accept = '<C-d>',
                    accept_word = '<M-w>',
                    accept_line = '<C-l>',
                    next = '<M-n>',
                    prev = '<M-p>',
                    dismiss = '/',
                },
            },
            filetypes = { markdown = true },
        },
        keys = keys,
        -- config = function(_, opts)
        --     local cmp = require 'cmp'
        --     local copilot = require 'copilot.suggestion'
        --     local luasnip = require 'luasnip'

        --     require('copilot').setup(opts)

        --     local function set_trigger(trigger)
        --         vim.b.copilot_suggestion_auto_trigger = trigger
        --         vim.b.copilot_suggestion_hidden = not trigger
        --     end

        --     -- Hide suggestions when the completion menu is open.
        --     cmp.event:on('menu_opened', function()
        --         if copilot.is_visible() then
        --             copilot.dismiss()
        --         end
        --         set_trigger(false)
        --     end)

        --     -- Disable suggestions when inside a snippet.
        --     cmp.event:on('menu_closed', function()
        --         set_trigger(not luasnip.expand_or_locally_jumpable())
        --     end)
        --     vim.api.nvim_create_autocmd('User', {
        --         pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
        --         callback = function()
        --             set_trigger(not luasnip.expand_or_locally_jumpable())
        --         end,
        --     })
        -- end,
    },
}
