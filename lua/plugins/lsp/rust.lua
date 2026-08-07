-- ~/.config/nvim/lua/plugins/rust.lua
--
-- Cross-platform Rust setup: works on macOS and Linux from the same file.
-- Everything kernel-related is Linux-only and simply does not load on macOS.

--------------------------------------------------------------------------------
-- Platform detection
--------------------------------------------------------------------------------

local sysname = vim.uv.os_uname().sysname
local is_mac = sysname == "Darwin"
local is_linux = sysname == "Linux"

--------------------------------------------------------------------------------
-- libclang discovery (bindgen needs LIBCLANG_PATH)
--
-- Linux: /usr/lib64 (Fedora-ish) or /usr/lib.
-- macOS: Homebrew LLVM, else the Xcode / CommandLineTools toolchain.
-- Result is cached; "" means "not found, don't set the env var at all".
--------------------------------------------------------------------------------

local libclang_cache = nil

local function has_libclang(dir)
    if dir == nil or dir == "" or vim.fn.isdirectory(dir) ~= 1 then
        return false
    end
    -- Matches libclang.dylib, libclang.so, libclang.so.19, ...
    return #vim.fn.glob(dir .. "/libclang*", true, true) > 0
end

local function libclang_path()
    if libclang_cache ~= nil then
        return libclang_cache ~= "" and libclang_cache or nil
    end

    local candidates = {}

    if is_mac then
        vim.list_extend(candidates, {
            "/opt/homebrew/opt/llvm/lib", -- brew, Apple Silicon
            "/usr/local/opt/llvm/lib", -- brew, Intel
        })

        if vim.fn.executable("xcode-select") == 1 then
            local dev = vim.trim(vim.fn.system({ "xcode-select", "-p" }))
            if vim.v.shell_error == 0 and dev ~= "" then
                vim.list_extend(candidates, {
                    -- Full Xcode
                    dev .. "/Toolchains/XcodeDefault.xctoolchain/usr/lib",
                    -- Standalone Command Line Tools
                    dev .. "/usr/lib",
                })
            end
        end
    else
        vim.list_extend(candidates, {
            "/usr/lib64",
            "/usr/lib",
            "/usr/lib/x86_64-linux-gnu",
        })
    end

    for _, dir in ipairs(candidates) do
        if has_libclang(dir) then
            libclang_cache = dir
            return dir
        end
    end

    libclang_cache = ""
    return nil
end

--------------------------------------------------------------------------------
-- rust-analyzer binary
--
-- Prefer ~/.cargo/bin, then anything on PATH (brew, rustup component).
-- Returning nil lets rustaceanvim fall back to its own lookup (e.g. Mason).
--------------------------------------------------------------------------------

-- vim.fn.executable() only checks the file has the exec bit set. On a
-- rustup install, ~/.cargo/bin/rust-analyzer is often just rustup's proxy
-- shim, which exists (and is "executable") for every tool name whether or
-- not that tool is actually installed for the active toolchain. Running it
-- then fails with "Unknown binary 'rust-analyzer' in official toolchain
-- ...". So we have to actually invoke --version and check it succeeds.
local function binary_actually_works(path)
    if path == nil or path == "" then
        return false
    end

    vim.fn.system({ path, "--version" })
    return vim.v.shell_error == 0
end

local rust_analyzer_cache = nil

local function rust_analyzer_cmd()
    if rust_analyzer_cache ~= nil then
        return rust_analyzer_cache ~= "" and { rust_analyzer_cache } or nil
    end

    -- Prefer rustup's own resolution: it knows which toolchain is active
    -- and whether rust-analyzer is actually installed for it, rather than
    -- us guessing at a path.
    if vim.fn.executable("rustup") == 1 then
        local resolved = vim.trim(vim.fn.system({ "rustup", "which", "rust-analyzer" }))
        if vim.v.shell_error == 0 and binary_actually_works(resolved) then
            rust_analyzer_cache = resolved
            return { resolved }
        end
    end

    local cargo_bin = vim.fs.normalize(vim.fn.expand("~/.cargo/bin/rust-analyzer"))
    if vim.fn.executable(cargo_bin) == 1 and binary_actually_works(cargo_bin) then
        rust_analyzer_cache = cargo_bin
        return { cargo_bin }
    end

    local on_path = vim.fn.exepath("rust-analyzer")
    if on_path ~= "" and binary_actually_works(on_path) then
        rust_analyzer_cache = on_path
        return { on_path }
    end

    rust_analyzer_cache = ""
    vim.notify(
        "rust-analyzer not found or not runnable for the active toolchain.\n"
            .. "Try: rustup component add rust-analyzer  (or: brew install rust-analyzer)",
        vim.log.levels.WARN
    )
    return nil
end

--------------------------------------------------------------------------------
-- Kernel dev: Linux only
--------------------------------------------------------------------------------

local kernel_root = nil

if is_linux then
    kernel_root = vim.fs.normalize(vim.fn.expand("~/crack-of-doom/projects/coding/oss/kernel"))

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
                    in_suggestion = true
                end

                -- Suggested replacement line usually looks like:
                -- 68 |         gsp_falcon: &Falcon<'_, GspEngine>,
                local suggested = line:match("^%s*%d+%s*|%s*(.*)$")
                if current and in_suggestion and suggested then
                    -- Keep the first code-looking line after `help:`, so we don't
                    -- capture the original source line before the help block.
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

        local cmd = {
            "make",
            "-C",
            kernel_root,
            "LLVM=1",
            "drivers/gpu/nova-core/",
        }

        local env = vim.fn.environ()
        local libclang = libclang_path()
        if libclang then
            env.LIBCLANG_PATH = libclang
        end

        vim.notify("Building nova-core...", vim.log.levels.INFO)

        vim.system(cmd, { text = true, env = env }, function(result)
            vim.schedule(function()
                local output = {}

                for _, stream in ipairs({ result.stdout, result.stderr }) do
                    for line in (stream or ""):gmatch("([^\n]*)\n?") do
                        if line ~= "" then
                            table.insert(output, line)
                        end
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
end

--------------------------------------------------------------------------------

return {
    {
        "mrcjkb/rustaceanvim",
        lazy = false,

        init = function()
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
                -- No kernel tree on macOS, so never take the Kbuild path there.
                if not kernel_root then
                    return false
                end

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
                    -- Normal Rust projects keep the usual behavior.
                    ra_settings.checkOnSave = true

                    ra_settings.check = {
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    }
                end

                -- Only export env vars we actually resolved on this machine.
                local cmd_env = {}
                local libclang = libclang_path()
                if libclang then
                    cmd_env.LIBCLANG_PATH = libclang
                end

                -- macOS: bindgen needs the SDK headers. Uncomment if a crate
                -- with C bindings fails with "'stdio.h' file not found".
                -- if is_mac and vim.fn.executable("xcrun") == 1 then
                --     local sdk = vim.trim(vim.fn.system({ "xcrun", "--show-sdk-path" }))
                --     if vim.v.shell_error == 0 and sdk ~= "" then
                --         cmd_env.SDKROOT = sdk
                --         cmd_env.BINDGEN_EXTRA_CLANG_ARGS = "-isysroot " .. sdk
                --     end
                -- end

                return {
                    dap = {
                        -- Apple's bundled lldb usually can't load Rust type
                        -- formatters; install codelldb (Mason) on macOS.
                        load_rust_types = not is_mac,
                    },

                    tools = {
                        executor = "quickfix",
                        code_actions = {
                            ui_select_fallback = true,
                        },
                    },

                    server = {
                        cmd = rust_analyzer_cmd(),
                        cmd_env = cmd_env,

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
        "cordx56/rustowl",
        enabled = false, -- Disable by default, enable when needed
        version = "*",
        build = "cargo binstall rustowl",
        lazy = false,
        opts = {
            client = {
                on_attach = function(_, buffer)
                    vim.lsp.config("rustowl", {})
                    vim.keymap.set("n", "<leader>o", function()
                        require("rustowl").toggle(buffer)
                    end, { buffer = buffer, desc = "Toggle RustOwl" })
                end,
            },
        },
    },
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            lsp = {
                enabled = true,
                on_attach = function(client, bufnr)
                    -- same on_attach as your other language servers,
                    -- can be omitted if you use an LspAttach autocmd
                end,
                actions = true,
                completion = true,
                hover = true,
            },
            completion = {
                crates = {
                    enabled = true,
                    max_results = 8,
                    min_chars = 3,
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
    },
}
