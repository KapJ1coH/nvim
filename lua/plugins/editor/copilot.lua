return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        keys = {
            { "<leader>cc", "<cmd>Copilot toggle<cr>", desc = "Toggle Copilot" },
            { "<leader>cp", "<cmd>Copilot panel<cr>", desc = "Show Copilot Panel" },
        },
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
                html = true,
                javascript = true,
                typescript = true,
                -- ["*"] = false,
            },
        },
    },
    {
        "saghen/blink.cmp",
        optional = true,
        dependencies = { "fang2hou/blink-copilot" },
        opts = {
            sources = {
                default = { "copilot" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },
        },
    }
}
