return {
	"nvim-neotest/neotest",
	-- event = "VeryLazy",
	enabled = true,
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
	},
	keys = {
		{
			"<leader>nr",
			"<cmd>Neotest run<cr>",
			desc = "Run neotest",
		},
		{
			"<leader>no",
			"<cmd>Neotest output<cr>",
			desc = "Neotest output pop-up",
		},
		{
			"<leader>nop",
			"<cmd>Neotest output-panel<cr>",
			desc = "Neotest output panel",
		},

		{
			"<leader>ns",
			"<cmd>Neotest summary<cr>",
			desc = "Neotest summary",
		},
		{
			"<leader>nss",
			"<cmd>Neotest stop<cr>",
			desc = "Neotest stop",
		},
		{
			"<leader>na",
			"<cmd>Neotest attach<cr>",
			desc = "Neotest attach",
		},
		{
			"<leader>nj",
			"<cmd>Neotest jump<cr>",
			desc = "Neotest jump",
		},
	},

	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					-- Extra arguments for nvim-dap configuration
					-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
					dap = { justMyCode = false },
					-- Command line arguments for runner
					-- Can also be a function to return dynamic values
					args = { "--log-level", "DEBUG" },
					-- Runner to use. Will use pytest if available by default.
					-- Can be a function to return dynamic value.
					runner = "pytest",
					-- Custom python path for the runner.
					-- Can be a string or a list of strings.
					-- Can also be a function to return dynamic value.
					-- If not provided, the path will be inferred by checking for
					-- virtual envs in the local directory and for Pipenev/Poetry configs
					python = ".venv/Scripts/python",
					-- Returns if a given file path is a test file.
					-- NB: This function is called a lot so don't perform any heavy tasks within it.
					-- is_test_file = function(file_path)
					--   ...
					-- end,
					--
					-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
					-- instances for files containing a parametrize mark (default: false)
					pytest_discover_instances = true,
				}),
				-- require("neotest-plenary"),
				-- require("neotest-vim-test")({
				-- 	ignore_file_types = { "python", "vim", "lua" },
				-- }),
			},
		})
	end,
}
