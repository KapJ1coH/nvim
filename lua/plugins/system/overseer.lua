local config_path = vim.fn.stdpath('config')

return {
    'stevearc/overseer.nvim',
    lazy = false,
    opts = {
        -- templates = {
        --     "builtin", "user.gcc_build.lua"
        --     -- "builtin", config_path .. "\\lua\\overseer\\template\\gcc_build.lua"
        -- }
    },
    config = function()
        print("Current path: " .. vim.fn.getcwd())
        require('overseer').setup({

            templates = {
                "builtin", "user.gcc_build.lua"

            }
        })
    end,
    keys = {
        { "<leader>o",  "<cmd>OverseerOpen<cr>" },
        { "<leader>or", "<cmd>OverseerRun<cr>" }
    }
}
