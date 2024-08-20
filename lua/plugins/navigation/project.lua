return {
	"ahmedkhalf/project.nvim",
	lazy = false,
	enabled = false,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		-- TODO test this shit
		require("project_nvim").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		})
		require("telescope").load_extension("projects")
	end,
}
