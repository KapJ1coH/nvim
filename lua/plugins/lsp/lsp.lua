-- -- lazy way
return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "pyright" },
            handlers = {
                function(server_name) -- default handler (optional)
                    if server_name ~= "rust_analyzer" then
                        require("lspconfig")[server_name].setup {}
                    end
                end,
                --     jdtls = function()
                --         require('java').setup {
                --             -- Your custom jdtls settings goes here
                --         }

                --         require('lspconfig').jdtls.setup {
                --             -- Your custom nvim-java configuration goes here
                --         }
                --     end,
            },
        },
        dependencies = {
            { "mason-org/mason.nvim", version = "^1.0.0", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        -- enabled = false,
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- { "hrsh7th/cmp-nvim-lsp" },
            {
                { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
                { "j-hui/fidget.nvim" },
                -- 'nvim-java/nvim-java',
            },
        },
        config = function()
            require('java').setup({
                root_markers = {
                    "settings.gradle",
                    "settings.gradle.kts",
                    "pom.xml",
                    "build.gradle",
                    "gradlew.bat",
                    "build.gradle",
                    "build.gradle.kts",
                },
                jdk = {
                    auto_install = false,
                },
            })

            local lspcfg = require('lspconfig')

            lspcfg.jdtls.setup({
                settings = {
                    java = {
                        configuration = {
                            runtimes = {
                                {
                                    name = "corretto-21",
                                    path = "C:\\Users\\timam\\scoop\\apps\\corretto21-jdk\\current\\bin\\java.exe",
                                    default = true,
                                }
                            }
                        }
                    }
                }
            })

            lspcfg.pyright.setup({
                pyright = {
                    settings = {
                        pyright = {
                            disableOrganizeImports = true, -- Using Ruff
                        },
                        python = {
                            analysis = {
                                ignore = { '*' }, -- Using Ruff
                                -- typeCheckingMode = 'off', -- Using mypy
                            },
                        },
                    },
                }
            })

            lspcfg.ruff.setup({
                init_options = {
                    settings = {
                        -- Ruff language server settings go here
                    }
                }
            })

            vim.keymap.set(
                "n",
                "gD",
                vim.lsp.buf.declaration,
                { desc = "Declaration", remap = false }
            )
            vim.keymap.set(
                "n",
                "gd",
                vim.lsp.buf.definition,
                { desc = "Definition", remap = false }
            )
            vim.keymap.set(
                "n",
                "gi",
                vim.lsp.buf.implementation,
                { desc = "Implementation", remap = false }
            )
            vim.keymap.set("n", "<leader>lws", function()
                vim.lsp.buf.workspace_symbol()
            end, { desc = "Workspace Symbol", remap = false })

            vim.keymap.set("n", "<leader>vd", function()
                vim.diagnostic.open_float()
            end, { desc = "Open Float", remap = false })

            vim.keymap.set("n", "[d", function()
                vim.diagnostic.goto_next()
            end, { desc = "Goto next", remap = false })

            vim.keymap.set("n", "]d", function()
                vim.diagnostic.goto_prev()
            end, { desc = "Goto prev", remap = false })

            vim.keymap.set("n", "<leader>lca", function()
                vim.lsp.buf.code_action()
            end, { desc = "Code Action", remap = false })

            vim.keymap.set("n", "<leader><leader>", function()
                vim.lsp.buf.code_action()
            end, { desc = "Code Action", remap = false })

            vim.keymap.set("n", "<leader>lrr", function()
                vim.lsp.buf.references()
            end, { desc = "References", remap = false })

            vim.keymap.set("n", "<leader>lrn", function()
                vim.lsp.buf.rename()
            end, { desc = "Rename Variable", remap = false })

            vim.keymap.set("i", "<C-h>", function()
                vim.lsp.buf.signature_help()
            end, { desc = "Signature Help", remap = false })
            -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
        end,
        -- -- This is where all the LSP shenanigans will live
        -- local lsp_zero = require("lsp-zero")
        -- lsp_zero.extend_lspconfig({
        --     sign_text = true,
        --     lsp_attach = lsp_attach,
        --     capabilities = require('cmp_nvim_lsp').default_capabilities(),
        -- })
        -- require('lspconfig').sqlls.setup {
        --     capabilities = capabilities,
        --     filetypes = { 'sql' },
        --     root_dir = function(_)
        --         return vim.loop.cwd()
        --     end,
        -- }

        -- require('lspconfig').sqls.setup {
        --     on_init = function(client)
        --         client.server_capabilities.documentFormattingProvider = false
        --         client.server_capabilities.documentFormattingRangeProvider = false
        --     end,
        --     on_attach = function(client, bufnr)
        --         require('sqls').on_attach(client, bufnr)
        --     end,
        -- }


        --- if you want to know more about lsp-zero and mason.nvim
        --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        -- lsp_zero.on_attach(function(client, bufnr)
        --     -- see :help lsp-zero-keybindings
        --     -- to learn the available actions
        --     local opts = { buffer = bufnr, remap = false }

        --     vim.keymap.set(
        --         "n",
        --         "gD",
        --         vim.lsp.buf.declaration,
        --         { desc = "Declaration", buffer = bufnr, remap = false }
        --     )
        --     vim.keymap.set(
        --         "n",
        --         "gd",
        --         vim.lsp.buf.definition,
        --         { desc = "Definition", buffer = bufnr, remap = false }
        --     )
        --     vim.keymap.set(
        --         "n",
        --         "gi",
        --         vim.lsp.buf.implementation,
        --         { desc = "Implementation", buffer = bufnr, remap = false }
        --     )
        --     vim.keymap.set("n", "<leader>lws", function()
        --         vim.lsp.buf.workspace_symbol()
        --     end, { desc = "Workspace Symbol", buffer = bufnr, remap = false })

        --     vim.keymap.set("n", "<leader>vd", function()
        --         vim.diagnostic.open_float()
        --     end, { desc = "Open Float", buffer = bufnr, remap = false })

        --     vim.keymap.set("n", "[d", function()
        --         vim.diagnostic.goto_next()
        --     end, { desc = "Goto next", buffer = bufnr, remap = false })

        --     vim.keymap.set("n", "]d", function()
        --         vim.diagnostic.goto_prev()
        --     end, { desc = "Goto prev", buffer = bufnr, remap = false })

        --     vim.keymap.set("n", "<leader>lca", function()
        --         vim.lsp.buf.code_action()
        --     end, { desc = "Code Action", buffer = bufnr, remap = false })

        --     vim.keymap.set("n", "<leader>lrr", function()
        --         vim.lsp.buf.references()
        --     end, { desc = "References", buffer = bufnr, remap = false })

        --     vim.keymap.set("n", "<leader>lrn", function()
        --         vim.lsp.buf.rename()
        --     end, { desc = "Rename Variable", buffer = bufnr, remap = false })

        --     vim.keymap.set("i", "<C-h>", function()
        --         vim.lsp.buf.signature_help()
        --     end, { desc = "Signature Help", buffer = bufnr, remap = false })
        --     -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
        -- end)


        -- -- Autoformat on save with Black
        -- local group = vim.api.nvim_create_augroup("Black", { clear = true })
        -- vim.api.nvim_create_autocmd("bufWritePost", {
        --     pattern = "*.py",
        --     command = "silent !black %",
        --     group = group,
        -- })
        -- end,
    },
}
