-- vim.g.rustaceanvim.tools.code_actions.ui_select_fallback = true


return {
    {
        'mrcjkb/rustaceanvim',
        lazy = false, -- This plugin is already lazy
        ft = { "rust", "rs" },

        init = function()
            -- runnables / outputs use toggleterm splits instead of default
            vim.g.rustaceanvim = {
                dap = {
                    load_rust_types = true,
                },
                tools = {
                    --         "termopen"|"quickfix"|"toggleterm"|"vimux"

                    executor     = "quickfix",
                    code_actions = {
                        ui_select_fallback = true, -- use vim.ui.select for code actions if rust-tools UI is not available
                    },
                },
                server = {
                    default_settings = {
                        -- rust-analyzer language server configuration
                        ["rust-analyzer"] = {
                            diagnostics = {
                                disabled = { "macro-error" },
                            },
                        }
                    },
                },
            }
        end,

        -- config = function ()
        --     vim.g.rustaceanvim.tools.code_actions.ui_select_fallback = true
        -- end,
        keys = {
            -- Rustaceanvim LSP actions (rust-only)
            {
                '<leader>ra',
                function()
                    vim.cmd.RustLsp('codeAction') -- grouped Rust code actions
                end,
                mode = { "n", "v" }
            },

            { '<leader>h', function()
                vim.cmd.RustLsp({ 'hover', 'actions' })
            end },

            {
                '<leader>rr',
                function()
                    vim.cmd.RustLsp('runnables')
                end,
                desc = "Rust: Runnables"
            },

            {
                '<leader>rt',
                function()
                    vim.cmd.RustLsp('testables')
                end,
                desc = "Rust: Testables"
            },

            {
                '<leader>rd',
                function()
                    vim.cmd.RustLsp('debuggables')
                end,
                desc = "Rust: Debuggables"
            },

            {
                '<leader>rD',
                function()
                    vim.cmd.RustLsp('debug')
                end,
                desc = "Rust: Debug current"
            },

            {
                '<leader>re',
                function()
                    vim.cmd.RustLsp('expandMacro')
                end,
                desc = "Rust: Expand macro"
            },

            {
                '<leader>rx',
                function()
                    vim.cmd.RustLsp('explainError')
                end,
                desc = "Rust: Explain error"
            },

            {
                '<leader>ro',
                function()
                    vim.cmd.RustLsp('openDocs')
                end,
                desc = "Rust: Open docs.rs"
            },

            {
                '<leader>rc',
                function()
                    vim.cmd.RustLsp('cargo')
                end,
                desc = "Rust: Cargo command"
            },
        }
    },
    {
        'cordx56/rustowl',
        enabled = false, -- Disable by default, enable when needed
        version = '*',   -- Latest stable version
        build = 'cargo binstall rustowl',
        lazy = false,    -- This plugin is already lazy
        opts = {
            client = {
                on_attach = function(_, buffer)
                    vim.lsp.config('rustowl', {})
                    vim.keymap.set('n', '<leader>o', function()
                        require('rustowl').toggle(buffer)
                    end, { buffer = buffer, desc = 'Toggle RustOwl' })
                end
            },
        },
    },
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        -- config = function()
        --     require('crates').setup()
        -- end,
        opts = {
            lsp = {
                enabled = true,
                on_attach = function(client, bufnr)
                    -- the same on_attach function as for your other language servers
                    -- can be ommited if you're using the `LspAttach` autocmd
                end,
                actions = true,
                completion = true,
                hover = true,
            },
            completion = {
                crates = {
                    enabled = true,  -- Disabled by default
                    max_results = 8, -- The maximum number of search results to display
                    min_chars = 3,   -- The minimum number of charaters to type before completions begin appearing
                },
            },

        },
        keys = {
            { "<leader>ct", function() require("crates").toggle() end,                             desc = "Toggle Crates" },
            { "<leader>cr", function() require("crates").reload() end,                             desc = "Reload Crates" },

            { "<leader>cv", function() require("crates").show_versions_popup() end,                desc = "Show Crate Versions" },
            { "<leader>cf", function() require("crates").show_features_popup() end,                desc = "Show Crate Features" },
            { "<leader>cd", function() require("crates").show_dependencies_popup() end,            desc = "Show Crate Dependencies" },

            { "<leader>cu", function() require("crates").update_crate() end,                       desc = "Update Crate" },
            { "<leader>cu", function() require("crates").update_crates() end,                      mode = "v",                           desc = "Update Crates" },
            { "<leader>ca", function() require("crates").update_all_crates() end,                  desc = "Update All Crates" },
            { "<leader>cU", function() require("crates").upgrade_crate() end,                      desc = "Upgrade Crate" },
            { "<leader>cU", function() require("crates").upgrade_crates() end,                     mode = "v",                           desc = "Upgrade Crates" },
            { "<leader>cA", function() require("crates").upgrade_all_crates() end,                 desc = "Upgrade All Crates" },

            { "<leader>cx", function() require("crates").expand_plain_crate_to_inline_table() end, desc = "Expand Crate to Inline Table" },
            { "<leader>cX", function() require("crates").extract_crate_into_table() end,           desc = "Extract Crate Into Table" },

            { "<leader>cH", function() require("crates").open_homepage() end,                      desc = "Open Homepage" },
            { "<leader>cR", function() require("crates").open_repository() end,                    desc = "Open Repository" },
            { "<leader>cD", function() require("crates").open_documentation() end,                 desc = "Open Documentation" },
            { "<leader>cC", function() require("crates").open_crates_io() end,                     desc = "Open Crates.io" },
            { "<leader>cL", function() require("crates").open_lib_rs() end,                        desc = "Open Lib.rs" },
        },

    }

}
