return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        {
            "folke/snacks.nvim",
            opts = {
                terminal = {},
            }
        }
    },
    event = "LspAttach",
    opts = {
        backend = "vim",
        -- Notification settings
        notify = {
            enabled = true,  -- Enable/disable all notifications
            on_empty = true, -- Show notification when no code actions are found
        },
        -- The icons to use for the code actions
        -- You can add your own icons, you just need to set the exact action's kind of the code action
        -- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
        signs = {
            quickfix = { "", { link = "DiagnosticWarning" } },
            others = { "", { link = "DiagnosticWarning" } },
            refactor = { "", { link = "DiagnosticInfo" } },
            ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
            ["refactor.extract"] = { "", { link = "DiagnosticError" } },
            ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
            ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
            ["source"] = { "", { link = "DiagnosticError" } },
            ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
            ["codeAction"] = { "", { link = "DiagnosticWarning" } },
        },

        picker = {
            "buffer",
            opts = {
                hotkeys = true,                       -- Enable hotkeys for quick selection of actions
                hotkeys_mode = "text_based",          -- Modes for generating hotkeys
                auto_preview = true,                  -- Enable or disable automatic preview
                auto_accept = false,                  -- Automatically accept the selected action (with hotkeys)
                position = "cursor",                  -- Position of the picker window
                winborder = "single",                 -- Border style for picker and preview windows
                keymaps = {
                    preview = "K",                    -- Key to show preview
                    close = { "q", "<Esc>" },         -- Keys to close the window (can be string or table)
                    select = "<CR>",                  -- Keys to select action (can be string or table)
                    preview_close = { "q", "<Esc>" }, -- Keys to return from preview to main window (can be string or table)
                },
                custom_keys = {
                    { key = 'm', pattern = 'Fill match arms' },
                    { key = 'r', pattern = 'Rename.*' }, -- Lua pattern matching
                },
                group_icon = " └",
            },
        },

    },
    keys = {
        { mode = { "n", "v" }, "<leader><leader>", function() require("tiny-code-action").code_action() end, { desc = "Code Actions", noremap = true, silent = true } },
    },
}
