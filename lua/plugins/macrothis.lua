return {
	"desdic/macrothis.nvim",
	depepndencies = {
		"nvim-telescope/telescope.nvim",
	},
	enabled = false,
	keys = {
		{
			"<Leader>kkd",
			function()
				require("macrothis").delete()
			end,
			desc = "delete",
		},
		{
			"<Leader>kke",
			function()
				require("macrothis").edit()
			end,
			desc = "edit",
		},
		{
			"<Leader>kkl",
			function()
				require("macrothis").load()
			end,
			desc = "load",
		},
		{
			"<Leader>kkn",
			function()
				require("macrothis").rename()
			end,
			desc = "rename",
		},
		{
			"<Leader>kkq",
			function()
				require("macrothis").quickfix()
			end,
			desc = "run macro on all files in quickfix",
		},
		{
			"<Leader>kkr",
			function()
				require("macrothis").run()
			end,
			desc = "run macro",
		},
		{
			"<Leader>kks",
			function()
				require("macrothis").save()
			end,
			desc = "save",
		},
		{
			"<Leader>kkx",
			function()
				require("macrothis").register()
			end,
			desc = "edit register",
		},
		{
			"<Leader>kkp",
			function()
				require("macrothis").copy_register_printable()
			end,
			desc = "Copy register as printable",
		},
		{
			"<Leader>kkm",
			function()
				require("macrothis").copy_macro_printable()
			end,
			desc = "Copy macro as printable",
		},
	},
	config = function()
		require("macrothis").setup({})
		require("telescope").load_extension("macrothis")
		require("telescope").extensions = {
			macrothis = {
				mappings = {
					load = "<CR>",
					save = "<C-s>",
					delete = "<C-d>",
					run = "<C-r>",
					rename = "<C-n>",
					edit = "<C-e>",
					quickfix = "<C-q>",
					register = "<C-x>",
					copy_macro = "<C-c>",
					help = "<C-h>",
				},
				items_display = {
					separator = " ",
					hl_chars = { ["["] = "TelescopeBorder", ["]"] = "TelescopeBorder" },
					items = {
						{ width = 50 },
						{ remaining = true },
					},
				},
				register_display = {
					separator = " ",
					hl_chars = { ["["] = "TelescopeBorder", ["]"] = "TelescopeBorder" },
					items = {
						{ width = 4 },
						{ remaining = true },
					},
				},
			},
		}
	end,
}
