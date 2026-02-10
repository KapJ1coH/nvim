-- local bufnr = vim.api.nvim_get_current_buf()
-- vim.keymap.set(
--     "n",
--     "<leader>a",
--     function()
--         vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
--         -- or vim.lsp.buf.codeAction() if you don't want grouping.
--     end,
--     { silent = true, buffer = bufnr }
-- )
-- vim.keymap.set(
--     "n",
--     "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
--     function()
--         vim.cmd.RustLsp({ 'hover', 'actions' })
--     end,
--     { silent = true, buffer = bufnr }
-- )

return {
    'mrcjkb/rustaceanvim',
    lazy = false, -- This plugin is already lazy
    ft = { "rust", "rs" },
    -- config = function()
    --     -- 1. Project Detection
    --     local root_json = vim.fs.root(0, { "rust-project.json" })
    --     local root_toml = vim.fs.root(0, { "rust-toolchain.toml" })

    --     local is_kernel = root_json ~= nil
    --     local is_esp = false

    --     -- Check if rust-toolchain.toml contains channel = "esp"
    --     if root_toml then
    --         local file = io.open(root_toml .. "/rust-toolchain.toml", "r")
    --         if file then
    --             local content = file:read("*a")
    --             if content:find('channel = "esp"') then
    --                 is_esp = true
    --             end
    --             file:close()
    --         end
    --     end

    --     -- 2. Paths
    --     local stable_toolchain = "/home/kapj1coh/.rustup/toolchains/stable-x86_64-unknown-linux-gnu"
    --     local ra_binary = stable_toolchain .. "/bin/rust-analyzer"
    --     local sysroot_src = stable_toolchain .. "/lib/rustlib/src/rust/library"

    --     vim.g.rustaceanvim = {
    --         server = {
    --             -- Always use the STABLE binary, even for ESP or Kernel projects
    --             cmd = function()
    --                 return { ra_binary }
    --             end,
    --             default_settings = {
    --                 ['rust-analyzer'] = {
    --                     -- Kernel Specifics
    --                     linkedProjects = is_kernel and { root_json .. "/rust-project.json" } or nil,
    --                     sysrootSrc = is_kernel and sysroot_src or nil,
    --                     checkOnSave = not is_kernel, -- Keep checkOnSave TRUE for ESP (it uses cargo)

    --                     -- ESP Specifics: Force it to use the proper cargo wrapper if needed
    --                     -- Usually defaults are fine, but ensure check command is correct
    --                     cargo = {
    --                         loadOutDirsFromCheck = not is_kernel,
    --                         allFeatures = is_esp, -- Often helpful for embedded
    --                     },
    --                     procMacro = { enable = true },
    --                 },
    --             },
    --         },
    --     }
    -- end,
    keys = {
        -- Rustaceanvim's keybindings are already set in the snippet above
        { '<leader>ra', function()
            vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        end },
        { '<leader>h', function()
            vim.cmd.RustLsp({ 'hover', 'actions' })
        end },
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
