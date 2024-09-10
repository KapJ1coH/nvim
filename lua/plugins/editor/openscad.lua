local flag = true
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	flag = false
end

return {
	"salkin-mada/openscad.nvim",

	dependencies = "L3MON4D3/LuaSnip",
	lazy = false,
	enabled = flag,

	config = function()
		require("openscad")
		-- load snippets, note requires
		vim.g.openscad_load_snippets = true
	end,
}
