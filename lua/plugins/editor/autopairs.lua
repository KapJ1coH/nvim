return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({})

		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")

        npairs.add_rules({
            Rule("*", "*", "markdown")
        })
	end,
}
