-- vim.g.rustaceanvim.tools.code_actions.ui_select_fallback = true




local kernel_root = vim.fs.normalize(
    vim.fn.expand("~/crack-of-doom/projects/coding/oss/kernel")
)

local function open_trouble_qflist()
    local ok, trouble = pcall(require, "trouble")

    if ok then
        trouble.open("qflist")
    else
        vim.cmd("copen")
    end
end

local function parse_rustc_pretty_output(lines)
    local items = {}
    local current = nil
    local pending_help = nil
    local in_suggestion = false

    local function flush()
        if current then
            if current.help then
                current.text = current.text .. " | help: " .. current.help
            end

            if current.suggestion then
                current.text = current.text .. " | suggestion: " .. current.suggestion
            end

            table.insert(items, current)
            current = nil
            pending_help = nil
            in_suggestion = false
        end
    end

    for _, line in ipairs(lines) do
        -- Start of a rustc error/warning:
        -- error[E0106]: missing lifetime specifier
        -- warning: hidden lifetime parameters in types are deprecated
        local severity, msg = line:match("^(error%[[^%]]+%]):%s*(.*)$")
        if not severity then
            severity, msg = line:match("^(error):%s*(.*)$")
        end
        if not severity then
            severity, msg = line:match("^(warning):%s*(.*)$")
        end

        if severity and msg then
            flush()

            current = {
                filename = "",
                lnum = 1,
                col = 1,
                type = severity:match("^error") and "E" or "W",
                text = severity .. ": " .. msg,
            }
        else
            -- Location line:
            --   --> drivers/gpu/nova-core/gsp/hal/tu102.rs:68:28
            local file, lnum, col = line:match("^%s*%-%-%>%s+([^:]+):(%d+):(%d+)")
            if current and file then
                current.filename = kernel_root .. "/" .. file
                current.lnum = tonumber(lnum)
                current.col = tonumber(col)
            end

            -- Help line:
            -- help: indicate the anonymous lifetime
            local help = line:match("^help:%s*(.*)$")
            if current and help then
                current.help = help
                pending_help = help
                in_suggestion = true
            end

            -- Suggested replacement line usually looks like:
            -- 68 |         gsp_falcon: &Falcon<'_, GspEngine>,
            local suggested = line:match("^%s*%d+%s*|%s*(.*)$")
            if current and in_suggestion and suggested then
                -- Keep the last code-looking line after `help:`.
                -- This avoids capturing the original source line before the help block.
                current.suggestion = suggested
                in_suggestion = false
            end
        end
    end

    flush()
    return items
end

vim.api.nvim_create_user_command("KernelNovaBuildTrouble", function()
    vim.cmd("wall")

    vim.env.LIBCLANG_PATH = "/usr/lib64"

    local cmd = {
        "make",
        "-C",
        kernel_root,
        "LLVM=1",
        "drivers/gpu/nova-core/",
    }

    vim.notify("Building nova-core...", vim.log.levels.INFO)

    vim.system(cmd, {
        text = true,
        stderr = true,
        env = vim.tbl_extend("force", vim.fn.environ(), {
            LIBCLANG_PATH = "/usr/lib64",
        }),
    }, function(result)
        vim.schedule(function()
            local output = {}

            for line in (result.stdout or ""):gmatch("([^\n]*)\n?") do
                if line ~= "" then
                    table.insert(output, line)
                end
            end

            for line in (result.stderr or ""):gmatch("([^\n]*)\n?") do
                if line ~= "" then
                    table.insert(output, line)
                end
            end

            local items = parse_rustc_pretty_output(output)

            vim.fn.setqflist({}, "r", {
                title = "kernel nova-core build",
                items = items,
            })

            if #items == 0 then
                vim.notify("Build finished with no parsed rustc diagnostics", vim.log.levels.INFO)
            else
                vim.notify("Parsed " .. #items .. " rustc diagnostics", vim.log.levels.INFO)
            end

            open_trouble_qflist()
        end)
    end)
end, {})

vim.keymap.set("n", "<leader>kb", "<cmd>KernelNovaBuildTrouble<CR>", {
    desc = "Kernel: build nova-core into Trouble",
})













-- local kernel_root = vim.fs.normalize(
--     vim.fn.expand("~/crack-of-doom/projects/coding/oss/kernel")
-- )
--
-- local function open_trouble_qflist()
--     local ok, trouble = pcall(require, "trouble")
--
--     if ok then
--         trouble.open("qflist")
--     else
--         vim.cmd("copen")
--     end
-- end
--
-- vim.api.nvim_create_user_command("KernelNovaBuild", function()
--     vim.cmd("wall")
--
--     -- What kernel-env was effectively fixing for Rust bindgen.
--     vim.env.LIBCLANG_PATH = "/usr/lib64"
--
--     -- Parse rustc-style diagnostics into quickfix.
--     vim.opt_local.errorformat = table.concat({
--         "%Eerror[%t%*[^]]]: %m",
--         "%Eerror: %m",
--         "%Wwarning: %m",
--         "%C%\\s%#--> %f:%l:%c",
--         "%C%\\s%#|",
--         "%C%\\s%#= note: %m",
--         "%C%\\s%#= help: %m",
--         "%Chelp: %m",
--         "%Z",
--     }, ",")
--
--     vim.opt_local.makeprg = table.concat({
--         "make",
--         "-C",
--         vim.fn.shellescape(kernel_root),
--         "LLVM=1",
--         "drivers/gpu/nova-core/",
--     }, " ")
--
--     -- Important: no extra args here.
--     vim.cmd("silent make")
--
--     open_trouble_qflist()
-- end, {})
--
-- vim.keymap.set("n", "<leader>kb", "<cmd>KernelNovaBuild<CR>", {
--     desc = "Kernel: build nova-core",
-- })


return {
    {
        "mrcjkb/rustaceanvim",
        lazy = false,

        init = function()
            local kernel_root =
                vim.fs.normalize(vim.fn.expand("~/crack-of-doom/projects/coding/oss/kernel"))

            local function strip_trailing_slash(path)
                local cleaned = path:gsub("/$", "")
                return cleaned
            end

            local function normalize(path)
                local absolute = vim.fn.fnamemodify(path, ":p")
                return vim.fs.normalize(strip_trailing_slash(absolute))
            end

            local function path_is_inside(path, root)
                path = normalize(path)
                root = normalize(root)

                return path == root or vim.startswith(path, root .. "/")
            end

            local function current_project_root()
                local bufname = vim.api.nvim_buf_get_name(0)
                local start

                if bufname ~= "" then
                    start = vim.fs.dirname(bufname)
                else
                    start = vim.uv.cwd()
                end

                local found = vim.fs.find(
                    { "rust-project.json", "Cargo.toml", ".git" },
                    { path = start, upward = true }
                )[1]

                if found then
                    return normalize(vim.fs.dirname(found))
                end

                return normalize(vim.uv.cwd())
            end

            local function is_kernel_repo()
                return path_is_inside(current_project_root(), kernel_root)
            end

            vim.g.rustaceanvim = function()
                local ra_settings = {
                    diagnostics = {
                        -- disabled = { "macro-error" },
                    },
                }

                if is_kernel_repo() then
                    ra_settings.linkedProjects = {
                        kernel_root .. "/rust-project.json",
                    }

                    -- Kernel Rust is not a normal Cargo project.
                    -- Let Kbuild be the checker, not cargo clippy.
                    ra_settings.checkOnSave = false

                    ra_settings.cargo = {
                        buildScripts = {
                            enable = false,
                        },
                    }
                else
                    -- Normal Rust projects keep your usual behavior.
                    ra_settings.checkOnSave = true

                    ra_settings.check = {
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    }
                end

                return {
                    dap = {
                        load_rust_types = true,
                    },

                    tools = {
                        executor = "quickfix",
                        code_actions = {
                            ui_select_fallback = true,
                        },
                    },

                    server = {
                        cmd = { vim.fn.expand("~/.cargo/bin/rust-analyzer") },

                        -- Useful if you launch nvim without running kernel-env first.
                        -- Harmless for normal projects.
                        cmd_env = {
                            LIBCLANG_PATH = "/usr/lib64",
                        },

                        default_settings = {
                            ["rust-analyzer"] = ra_settings,
                        },
                    },
                }
            end
        end,

        keys = {
            {
                "<leader>ra",
                function()
                    vim.cmd.RustLsp("codeAction")
                end,
                mode = { "n", "v" },
                desc = "Rust: Code action",
            },

            {
                "<leader>h",
                function()
                    vim.cmd.RustLsp({ "hover", "actions" })
                end,
                desc = "Rust: Hover actions",
            },

            {
                "<leader>rr",
                function()
                    vim.cmd.RustLsp("runnables")
                end,
                desc = "Rust: Runnables",
            },

            {
                "<leader>rt",
                function()
                    vim.cmd.RustLsp("testables")
                end,
                desc = "Rust: Testables",
            },

            {
                "<leader>rd",
                function()
                    vim.cmd.RustLsp("debuggables")
                end,
                desc = "Rust: Debuggables",
            },

            {
                "<leader>rD",
                function()
                    vim.cmd.RustLsp("debug")
                end,
                desc = "Rust: Debug current",
            },

            {
                "<leader>re",
                function()
                    vim.cmd.RustLsp("expandMacro")
                end,
                desc = "Rust: Expand macro",
            },

            {
                "<leader>rx",
                function()
                    vim.cmd.RustLsp("explainError")
                end,
                desc = "Rust: Explain error",
            },

            {
                "<leader>ro",
                function()
                    vim.cmd.RustLsp("openDocs")
                end,
                desc = "Rust: Open docs.rs",
            },

            {
                "<leader>rc",
                function()
                    vim.cmd.RustLsp("cargo")
                end,
                desc = "Rust: Cargo command",
            },
        },
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
