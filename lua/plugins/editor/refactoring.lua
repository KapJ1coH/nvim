return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    -- lazy = false,
    config = function()
        require("refactoring").setup()

    end,


    keys = {
        {mode="x", "<leader>re", ":Refactor extract ",},
        {mode="x", "<leader>rf", ":Refactor extract_to_file ",},
        {mode="x", "<leader>rv", ":Refactor extract_var ",},
        {mode={ "n", "x" }, "<leader>ri", ":Refactor inline_var",},
        {mode="n", "<leader>rI", ":Refactor inline_func",},
        {mode="n", "<leader>rb", ":Refactor extract_block",},
        {mode="n", "<leader>rbf", ":Refactor extract_block_to_file",},

    }
}
