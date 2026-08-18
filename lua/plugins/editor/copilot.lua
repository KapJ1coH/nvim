
local sysname = vim.uv.os_uname().sysname
local is_mac = sysname == "Darwin"
local is_linux = sysname == "Linux"


local disable = false
if is_mac then
    disable = true
end

return {
    {
        "zbirenbaum/copilot.lua",
        enabled = false,
        cmd = "Copilot",
        event = "InsertEnter",
        keys = {
            { "<leader>cc", "<cmd>Copilot toggle<cr>", desc = "Toggle Copilot" },
            { "<leader>cp", "<cmd>Copilot panel<cr>",  desc = "Show Copilot Panel" },
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
                        score_offset = -100,
                        async = true,
                    },
                },
            },
        },
    }
}
