return {
    "L3MON4D3/LuaSnip",

    dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" }, -- Snippets source.
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
        ls.config.set_config(opts)

        ls.add_snippets("latex", {
            s("bjs", {
                t("Hello, world!"),
                i(1),
            }),
        })
        vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
        vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
    end,
}
