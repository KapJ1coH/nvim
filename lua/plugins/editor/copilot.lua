local username = vim.fn.expand('$USER')
if username == '$USER' then
    username = vim.fn.expand('$USERNAME')
end

if username == 'ty096829' then
    return {
        "github/copilot.vim",
        lazy = false,
        enabled = false,
    }
    end

return {
    "github/copilot.vim",
    lazy = false,
}
