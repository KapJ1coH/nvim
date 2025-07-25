return {
	"mfussenegger/nvim-lint",
    keys = {
        { "<leader>pl", function() require("lint").linters_by_ft = { python = { "pylint" }, } end,              desc = "Lint current buffer" },
    },

	event = { "BufEnter", "BufNewFile" },

	config = function()
		-- Set linters
		require("lint").linters_by_ft = { python = { "pylint" }, }

		-- Set running linters on buffer save
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})

        local lint = require("lint")
        lint.linters.pylint = require("lint.util").wrap(lint.linters.pylint, function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.WARN
            return diagnostic
        end)

	end,
}
