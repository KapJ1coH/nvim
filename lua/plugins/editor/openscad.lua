return {
	"salkin-mada/openscad.nvim",

	dependencies = "L3MON4D3/LuaSnip",
	lazy = false,

	config = function()
		require("openscad")
		-- load snippets, note requires
		vim.g.openscad_load_snippets = true
	end,
}
