-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "python" },
-- 	callback = function()
-- 		require("swenv.api").auto_venv()
-- 	end,
-- })

return {
	"AckslD/swenv.nvim",
	enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ahmedkhalf/project.nvim",
	},
	lazy = false,

	opts = {},

	-- TODO integrate into lualine
	-- https://github.com/AckslD/swenv.nvim
	--
	-- FIX fix this, it's not working
}
