return {
    "L3MON4D3/LuaSnip",

    dependencies = { "rafamadriz/friendly-snippets"}, -- Snippets source.
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },

    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    config = function(_, opts)
        require("luasnip.loaders.from_vscode").load()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        ls.config.set_config(opts)
        local keymap = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }
        local fmt = require("luasnip.extras.fmt").fmt
        local rep = require("luasnip.extras").rep

        -- This becomes print(f"variable = {variable}")
        ls.add_snippets("python", {
            s("pv", fmt('print(f"{{{}=}}")', {i(1, "variable")}))
        })




    end,
    keys = {
        { "<c-j>", mode = "i", "<cmd>lua require'luasnip'.jump(-1)<CR>" },
        { "<c-j>", mode = "s", "<cmd>lua require'luasnip'.jump(-1)<CR>" },
        { "<c-k>", mode = "i", "<cmd>lua require'luasnip'.jump(1)<CR>" },
        { "<c-k>", mode = "s", "<cmd>lua require'luasnip'.jump(1)<CR>" },
        { "<c-x>", mode = "i", "<cmd>lua require'luasnip'.expand()<CR>" },
    },
}
