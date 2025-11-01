-- -- lazy way
return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "pyright" },
            handlers = {
                function(server_name) -- default handler (optional)
                    if server_name ~= "rust_analyzer" then
                        -- require("lspconfig")[server_name].setup {} -- deprecated
                        vim.lsp.config("*", {})
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

            -- local lspcfg = require('lspconfig')

            vim.lsp.config('jdtls', {
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

            -- lspcfg.jdtls.setup({
            --     settings = {
            --         java = {
            --             configuration = {
            --                 runtimes = {
            --                     {
            --                         name = "corretto-21",
            --                         path = "C:\\Users\\timam\\scoop\\apps\\corretto21-jdk\\current\\bin\\java.exe",
            --                         default = true,
            --                     }
            --                 }
            --             }
            --         }
            --     }
            -- })

            vim.lsp.config('pyright', {
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

            -- lspcfg.pyright.setup({
            --     pyright = {
            --         settings = {
            --             pyright = {
            --                 disableOrganizeImports = true, -- Using Ruff
            --             },
            --             python = {
            --                 analysis = {
            --                     ignore = { '*' }, -- Using Ruff
            --                     -- typeCheckingMode = 'off', -- Using mypy
            --                 },
            --             },
            --         },
            --     }
            -- })

            vim.lsp.enable({
                "ruff",
                "jdtls",
                "pyright",
                "rust-analyzer",

            })
            -- lspcfg.ruff.setup({
            --     init_options = {
            --         settings = {
            --             -- Ruff language server settings go here
            --         }
            --     }
            -- })

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
    },
}
