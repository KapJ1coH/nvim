-- lazy way
return {
    -- 'VonHeikemen/lsp-zero.nvim',
    -- dependencies = {
    --     --- Uncomment these if you want to manage LSP servers from neovim
    --     {'williamboman/mason.nvim'},
    --     {'williamboman/mason-lspconfig.nvim'},

    --     -- LSP Support
    --     {'neovim/nvim-lspconfig'},
    --     -- Autocompletion
    --     {'hrsh7th/nvim-cmp'},
    --     {'hrsh7th/cmp-nvim-lsp'},
    --     {'L3MON4D3/LuaSnip'},

    --     {'nanotee/nvim-lsp-basics'},
    --     {'lukas-reineke/cmp-rg'},

    -- }
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        -- branch = 'better-defaults',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    -- local cmp = require('cmp')
    --
    -- cmp.setup({
    --   preselect = 'item',
    --   completion = {
    --     completeopt = 'menu,menuone,noinsert'
    --   },
    --   mapping = cmp.mapping.preset.insert({
    --      ['<CR>'] = cmp.mapping.confirm({select = true}),
    --   })
    -- })
    --
    -- -- If you want insert `(` after select function or method item
    -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    -- cmp.event:on(
    --   'confirm_done',
    --   cmp_autopairs.on_confirm_done()
    -- )
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'rg' },
                    { name = 'fd' },

                },
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
            end)


            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'pyright' },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })


            -- Autoformat on save with Black
            local group = vim.api.nvim_create_augroup("Black", { clear = true })
            vim.api.nvim_create_autocmd("bufWritePost", {
                pattern = "*.py",
                command = "silent !black %",
                group = group,
            })
        end
    }
}
