return {
    {
        "ray-x/go.nvim",
        dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig" },
        -- version = "v0.11",  -- UNCOMMENT if on Neovim 0.11
        ft = { "go", "gomod", "gowork", "gotmpl" },
        opts = {
            -- go.nvim owns gopls. Table form merges into its defaults.
            lsp_cfg = {
                settings = {
                    gopls = {
                        buildFlags = {}, -- drop the default integration tag
                        directoryFilters = { "-.git", "-node_modules", "-vendor" },
                    },
                },
            },
            lsp_gofumpt = true,  -- gofumpt inside gopls
            lsp_keymaps = false, -- your unified keymaps instead
            lsp_inlay_hints = { enable = true },
            lsp_codelens = true,
            lsp_document_formatting = false, -- conform.nvim owns formatting
            diagnostic = false,              -- trouble/fidget own diagnostics

            -- your dap stack already exists; take the adapter, not the keymaps
            dap_debug = true,
            dap_debug_keymap = false,
            dap_debug_gui = false,
            dap_debug_vt = false,

            trouble = true, -- you have trouble.nvim
            luasnip = true,
            test_runner = "go",
            run_in_floaterm = true,
            golangci_lint = { default = "standard" },
        },
        config = function(_, opts)
            require("go").setup(opts)
            -- keymaps: same FileType autocmd block from before

        end,
        keys = {
            -- navigation
            { "<leader>Ga",  "<cmd>GoAlt<cr>",            ft = "go",              desc = "Alt file (src <-> test)" },
            { "<leader>GA",  "<cmd>GoAltV<cr>",           ft = "go",              desc = "Alt file (vsplit)" },
            -- codegen / refactor
            { "<leader>Ge",  "<cmd>GoIfErr<cr>",          ft = "go",              desc = "Generate if err" },
            { "<leader>Gi",  "<cmd>GoImpl<cr>",           ft = "go",              desc = "Implement interface" },
            { "<leader>Gf",  "<cmd>GoFillStruct<cr>",     ft = "go",              desc = "Fill struct" },
            { "<leader>GF",  "<cmd>GoFillSwitch<cr>",     ft = "go",              desc = "Fill switch" },
            { "<leader>Gp",  "<cmd>GoFixPlurals<cr>",     ft = "go",              desc = "Fix plural params" },
            { "<leader>Gd",  "<cmd>GoCmt<cr>",            ft = "go",              desc = "Add doc comment" },
            -- struct tags
            { "<leader>Gst", "<cmd>GoAddTag<cr>",         ft = "go",              desc = "Add tag" },
            { "<leader>GsT", "<cmd>GoRmTag<cr>",          ft = "go",              desc = "Remove tag" },
            { "<leader>Gj",  "<cmd>GoAddTag json<cr>",    ft = "go",              desc = "Add json tag" },
            { "<leader>Gy",  "<cmd>GoAddTag yaml<cr>",    ft = "go",              desc = "Add yaml tag" },
            -- test scaffolding (gotests)
            { "<leader>Gta", "<cmd>GoAddTest<cr>",        ft = "go",              desc = "Generate test for func" },
            { "<leader>GtA", "<cmd>GoAddAllTest<cr>",     ft = "go",              desc = "Generate tests for all funcs" },
            { "<leader>Gtx", "<cmd>GoAddExpTest<cr>",     ft = "go",              desc = "Generate tests (exported)" },
            { "<leader>Gts", "<cmd>GoTestSum -w<cr>",     ft = "go",              desc = "gotestsum watch mode" },
            { "<leader>Gt",  "<cmd>GoTest -w<cr>",        ft = "go",              desc = "go test" },
            { "<leader>Gtf", "<cmd>GoTestFile -w<cr>",    ft = "go",              desc = "go test file" },
            { "<leader>Gtp", "<cmd>GoTestPackage -w<cr>", ft = "go",              desc = "go test package" },
            -- module / deps
            { "<leader>Gm",  "<cmd>GoModTidy<cr>",        ft = { "go", "gomod" }, desc = "go mod tidy" },
            { "<leader>GM",  "<cmd>GoModVendor<cr>",      ft = { "go", "gomod" }, desc = "go mod vendor" },
            { "<leader>Gg",  "<cmd>GoGet<cr>",            ft = { "go", "gomod" }, desc = "go get" },
            -- build / check
            { "<leader>Gb",  "<cmd>GoBuild<cr>",          ft = "go",              desc = "go build" },
            { "<leader>Gr",  "<cmd>GoRun<cr>",            ft = "go",              desc = "go run" },
            { "<leader>Gv",  "<cmd>GoVet<cr>",            ft = "go",              desc = "go vet" },
            { "<leader>Gl",  "<cmd>GoLint<cr>",           ft = "go",              desc = "golangci-lint" },
            { "<leader>Gz",  "<cmd>GoGenerate<cr>",       ft = "go",              desc = "go generate" },
            -- misc
            { "<leader>Gc",  "<cmd>GoCodeLenAct<cr>",     ft = "go",              desc = "Run codelens action" },
            { "<leader>Gh",  "<cmd>GoCheat<cr>",          ft = "go",              desc = "Go cheatsheet" },
            { "<leader>Gsq", function () require('otter').activate({ 'sql' }, true, true) end, desc = "go activate sql" },
        },

    },

    {
        "nvim-neotest/neotest",
        -- optional = true,
        dependencies = {
            {
                "fredrikaverpil/neotest-golang",
                version = "*",
                dependencies = { { "leoluz/nvim-dap-go", opts = {} } },
            },
        },
        opts = function(_, opts)
            opts.adapters = opts.adapters or {}
            table.insert(opts.adapters, require("neotest-golang")({
                runner = "go",
                go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
                dap_go_enabled = true,
                warn_test_name_dupes = false,
            }))
            return opts
        end,
    }
}
