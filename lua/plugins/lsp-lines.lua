return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    name = 'lsp_lines.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    enabled = false,
    config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
            virtual_text = false,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
            signs = true,
            underline = true,
            update_in_insert = true,
            severity_sort = false,
        })
    end,
}
