return {
    name = "gcc build",
    builder = function()
        local file = vim.fn.expand("%:p")
        return {
            cmd = { "gcc" },
            args = {file},
            components = {
                { "on_output_quickfix", open = true },
                "default",
            },
        }
    end,
    condition = {
        filetype = { "c" },
    },
}
