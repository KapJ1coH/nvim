return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
        -- Here is where you configure the autocompletion settings.
        local lsp_zero = require("lsp-zero")
        lsp_zero.extend_cmp()

        -- And you can configure cmp even more, if you want to.
        local cmp = require("cmp")
        local cmp_action = lsp_zero.cmp_action()
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local luasnip = require("luasnip")

        cmp.setup({
            sources = {
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "rg" },
                { name = "fd" },
                { name = "buffer" },
                { name = "luasnip" },
            },

            snippet = {
                expand = function(args)
                    require'luasnip'.lsp_expand(args.body)
                end
            },


            formatting = lsp_zero.cmp_format(),
            -- mapping = cmp.mapping.preset.insert({
            --     ["<C-f>"] = cmp_action.luasnip_jump_forward(),
            --     ["<C-b>"] = cmp_action.luasnip_jump_backward(),
            --     ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            --     ["<C-d>"] = cmp.mapping.scroll_docs(4),
            --     ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            --     ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            --     ["<CR>"] = cmp.mapping.confirm({ select = true }),
            --     ["<C-Space>"] = cmp.mapping.complete(),
            -- }),
            mapping = {

                -- ... Your other mappings ...
                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    else
                        fallback()
                    end
                end),

                -- NOTE unused for now
                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_next_item()
                --     elseif luasnip.locally_jumpable(1) then
                --         luasnip.jump(1)
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),

                -- ["<S-Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_prev_item()
                --     elseif luasnip.locally_jumpable(-1) then
                --         luasnip.jump(-1)
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),

                -- ... Your other mappings ...
            },
            preselect = "item",
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
        })
    end,
}
