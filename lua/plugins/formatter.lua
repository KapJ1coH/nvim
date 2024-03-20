return {
    "mhartington/formatter.nvim",
    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    event = "VeryLazy",
    enabled = false,
    keys = {
        { "<leader>f", ':Format<cr>',      silent = true, noremap = true },
        { "<leader>F", ':FormatWrite<CR>', silent = true, noremap = true },
    },
    config = function()
        local formatter = require("formatter")
        local opts = {
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
                            args = { "" },
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
        formatter.setup(opts)
    end,
}
