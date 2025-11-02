return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR> <BAR> :UndotreeFocus<CR>")
		vim.g.undotree_WindowLayout = "2"
	end,
	lazy = false,
}
