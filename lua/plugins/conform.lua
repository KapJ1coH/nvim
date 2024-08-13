-- Autoformat on save with Black
local group = vim.api.nvim_create_augroup("Black", { clear = true })
vim.api.nvim_create_autocmd("bufWritePost", {
	pattern = "*.py",
	command = "silent !black %",
	group = group,
})

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			desc = "Format buffer",
		},
	},

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			-- python = { "isort", "ruff_fix", "black" },
			-- python = { "black" },
			-- Use a sub-list to run only the first available formatter
			xml = { "xmlformat" },
			json = { "jq" },
			javascript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			clojure = { "cljstyle" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true,
			-- async = true,
		},
		log_level = vim.log.levels.DEBUG,
	},
	-- init = function()
	--     -- If you want the formatexpr, here is the place to set it
	--     vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	-- end,
}

-- { "black", "--stdin-filename", "C:\\Projects\\Coulis-Beamformer\\src\\coulis_beamformer\\features\\tests\\NPR.py", "--quiet", "-" }
-- { black --stdin-filename C:\\Projects\\Coulis-Beamformer\\src\\coulis_beamformer\\features\\tests\\NPR.py --quiet - }
