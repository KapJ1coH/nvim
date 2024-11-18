local username = vim.fn.expand('$USER')
if username == '$USER' then
    username = vim.fn.expand('$USERNAME')
end

if username == 'ty096829' then
    return {
        "nanotee/sqls.nvim",
        lazy = false,
        enabled = false,
    }
end


return {
    "nanotee/sqls.nvim",
    lazy = false,
}
