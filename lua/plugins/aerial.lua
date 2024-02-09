local M = {
    "stevearc/aerial.nvim",
    -- event = "VeryLazy",
    config = function()
        on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set({ "n", "v" }, "(", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set({ "n", "v" }, ")", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end
    end,
    keys = {
        { "<leader>ae", "<cmd>AerialNavToggle<CR>" },
    }
}

return M
