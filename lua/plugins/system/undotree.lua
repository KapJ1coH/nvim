return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR> <BAR> :UndotreeFocus<CR>")
		vim.g.undotree_DiffCommand = "FC"
	end,
	lazy = false,
}
