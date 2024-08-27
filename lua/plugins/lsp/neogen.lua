return {
	"danymat/neogen",
	config = true,
	version = "*",
	-- event = "InsertEnter",

	opts = {
		snippet_engine = "luasnip",
		languages = {
			python = {
				template = {
					annotation_convention = "reST",
				},
			},
		},
	},

	keys = {
		{ "<leader>o", "<cmd>OverseerOpen<cr>" },
		{
			"<leader>nc",
			"<cmd>Neogen class<cr>",
			desc = "Generate doc for the class",
		},
		{
			"<leader>nf",
			"<cmd>Neogen func<cr>",
			desc = "Generate doc for the function",
		},
		{
			"<leader>nt",
			"<cmd>Neogen type<cr>",
			desc = "Generate doc for the type",
		},
		{
			"<leader>nfl",
			"<cmd>Neogen file<cr>",
			desc = "Generate doc for the file",
		},
	},
}
