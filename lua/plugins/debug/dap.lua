vim.api.nvim_create_augroup("DapGroup", { clear = true })

---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == 'function' and (config.args() or {})
        or config.args
        or {} --[[@as string[] | string ]]
    local args_str = type(args) == 'table' and table.concat(args, ' ') or args --[[@as string]]

    config = vim.deepcopy(config)
    ---@cast args string[]
    config.args = function()
        local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str)) --[[@as string]]
        if config.type and config.type == 'java' then
            ---@diagnostic disable-next-line: return-type-mismatch
            return new_args
        end
        return require('dap.utils').splitstr(new_args)
    end
    return config
end


local function navigate(args)
    local buffer = args.buf

    local wid = nil
    local win_ids = vim.api.nvim_list_wins() -- Get all window IDs
    for _, win_id in ipairs(win_ids) do
        local win_bufnr = vim.api.nvim_win_get_buf(win_id)
        if win_bufnr == buffer then
            wid = win_id
        end
    end

    if wid == nil then
        return
    end

    vim.schedule(function()
        if vim.api.nvim_win_is_valid(wid) then
            vim.api.nvim_set_current_win(wid)
        end
    end)
end

local function create_nav_options(name)
    return {
        group = "DapGroup",
        pattern = string.format("*%s*", name),
        callback = navigate
    }
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "theHamsta/nvim-dap-virtual-text",
        },
        lazy = false,
        config = function()
            local dap = require("dap")
            local virtual_text = require("nvim-dap-virtual-text")
            virtual_text.setup()

            dap.set_log_level("DEBUG")
        end,
        keys = {
            { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
            { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
            { "<leader>de", function() require("dapui").eval() end,                                               desc = "Evaluate" },
            { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
            { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
            { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
            { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
            { "<leader>do", function() require("dap").step_over() end,                                            desc = "Step Over" },
            { "<leader>dO", function() require("dap").step_out() end,                                             desc = "Step Out" },
            { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
            { "<leader>du", function() require("dapui").toggle() end,                                             desc = "Toggle DAPUI" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
        },

    },


    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
        },
        keys = {
            { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
            { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local function layout(name)
                return {
                    elements = {
                        { id = name },
                    },
                    enter = true,
                    size = 40,
                    position = "right",
                }
            end
            local name_to_layout = {
                repl = { layout = layout("repl"), index = 0 },
                stacks = { layout = layout("stacks"), index = 0 },
                scopes = { layout = layout("scopes"), index = 0 },
                console = { layout = layout("console"), index = 0 },
                watches = { layout = layout("watches"), index = 0 },
                breakpoints = { layout = layout("breakpoints"), index = 0 },
            }
            local layouts = {}

            for name, config in pairs(name_to_layout) do
                table.insert(layouts, config.layout)
                name_to_layout[name].index = #layouts
            end

            local function toggle_debug_ui(name)
                dapui.close()
                local layout_config = name_to_layout[name]

                if layout_config == nil then
                    error(string.format("bad name: %s", name))
                end

                local uis = vim.api.nvim_list_uis()[1]
                if uis ~= nil then
                    layout_config.size = uis.width
                end

                pcall(dapui.toggle, layout_config.index)
            end

            vim.keymap.set("n", "<leader>dr", function() toggle_debug_ui("repl") end, { desc = "Debug: toggle repl ui" })
            vim.keymap.set("n", "<leader>ds", function() toggle_debug_ui("stacks") end,
                { desc = "Debug: toggle stacks ui" })
            vim.keymap.set("n", "<leader>dw", function() toggle_debug_ui("watches") end,
                { desc = "Debug: toggle watches ui" })
            vim.keymap.set("n", "<leader>db", function() toggle_debug_ui("breakpoints") end,
                { desc = "Debug: toggle breakpoints ui" })
            vim.keymap.set("n", "<leader>dS", function() toggle_debug_ui("scopes") end,
                { desc = "Debug: toggle scopes ui" })
            vim.keymap.set("n", "<leader>dc", function() toggle_debug_ui("console") end,
                { desc = "Debug: toggle console ui" })

            vim.api.nvim_create_autocmd("BufEnter", {
                group = "DapGroup",
                pattern = "*dap-repl*",
                callback = function()
                    vim.wo.wrap = true
                end,
            })

            vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("dap-repl"))
            vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("DAP Watches"))

            dapui.setup({
                layouts = layouts,
                enter = true,
            })

            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            dap.listeners.after.event_output.dapui_config = function(_, body)
                if body.category == "console" then
                    dapui.eval(body.output) -- Sends stdout/stderr to Console
                end
            end
        end,
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "mfussenegger/nvim-dap",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "delve",
                },
                automatic_installation = true,
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })
        end,
    },

    {
        "mfussenegger/nvim-dap-python",
        keys = {
            -- **Test-Related Key Mappings**
            {
                mode = "n",
                "<leader>dm",
                function()
                    require("dap-python").test_method()
                end,
                desc = "Debug Test Method",
            },
            {
                mode = "n",
                "<leader>dcl",
                function()
                    require("dap-python").test_class()
                end,
                desc = "Debug Test Class",
            },
            -- **File-Related Key Mappings**
            {
                mode = "n",
                "<leader>df",
                function()
                    require("dap-python").debug_file()
                end,
                desc = "Debug Python File",
            },

            -- -- **Function-Related Key Mappings**
            -- {
            --     mode = "n",
            --     "<leader>du",
            --     function()
            --         -- Custom function to debug the function under the cursor
            --         local dap_python = require("dap-python")
            --         local utils = require("dap-python.utils")
            --         local path = vim.fn.expand("%:p")
            --         local row = vim.fn.line(".")
            --         local func_name = utils.get_func_at_line(path, row)
            --         if func_name then
            --             dap_python.debug_at_point()
            --         else
            --             print("No function found under cursor.")
            --         end
            --     end,
            --     desc = "Debug Function Under Cursor",
            -- },

            -- -- **Class-Related Key Mappings**
            -- {
            --     mode = "n",
            --     "<leader>dk",
            --     function()
            --         -- Custom function to debug the class under the cursor
            --         local dap_python = require("dap-python")
            --         local utils = require("dap-python.utils")
            --         local path = vim.fn.expand("%:p")
            --         local row = vim.fn.line(".")
            --         local class_name = utils.get_class_at_line(path, row)
            --         if class_name then
            --             dap_python.debug_at_point()
            --         else
            --             print("No class found under cursor.")
            --         end
            --     end,
            --     desc = "Debug Class Under Cursor",
            -- },
        },
        config = function()
            -- require("dap-python").setup("uv")
            -- require("dap-python").setup("python")
            require("dap-python").setup("C:/Users/ty096829/AppData/Local/Programs/Python/Python311/python.exe")

            require("dap-python").test_runner = "pytest"
        end,
    }


}



--
