return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    name = 'lsp_lines.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
            virtual_text = false,
        })
    end,
}
