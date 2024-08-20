return {
    "smjonas/live-command.nvim",
    -- live-command supports semantic versioning via tags
    -- tag = "1.*",
    event = "BufEnter",
    config = function()
        require("live-command").setup {
            commands = {
                Norm = { cmd = "norm" },
            },
        }
    end,
}
