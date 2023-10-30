-- Utilities for creating configurations
local util = require "formatter.util"

vim.keymap.set('n', "<leader>f", ':Format<cr>', {silent=true, noremap=true})
vim.keymap.set('n', "<leader>F", ':FormatWrite<CR>', {silent=true, noremap=true})

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        python = {
            -- black for Python
            require("formatter.filetypes.python").black,
            function()
                return {
                    exe = "black",
                    args = {""},
                    stdin = true,
                }
            end,
        },
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace
        }
    }
}
