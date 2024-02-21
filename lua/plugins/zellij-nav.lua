return {
    "https://git.sr.ht/~swaits/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
        { "<s-Left>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left" } },
        { "<s-Down>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down" } },
        { "<s-Up>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up" } },
        { "<s-Right>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
    },
    opts = {},
}
