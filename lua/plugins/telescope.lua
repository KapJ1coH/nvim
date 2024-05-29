local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		-- {
		-- 	"nvim-telescope/telescope-fzf-native.nvim",
		-- 	build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		-- },
		{ "nvim-telescope/telescope-file-browser.nvim" },
	},
	lazy = false,
	opts = {
		defaults = {
			file_ignore_patterns = {
				"tags",
			},
		},
		pickers = {
			find_files = {
				find_command = { "fd" },
			},
			grep_string = {
				"rg",
			},
		},
		buffers = {
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer + actions.move_to_top,
				},
			},
		},
	},
	extensions = {
		extensions = {
			-- fzf = {
			-- 	fuzzy = true, -- false will only do exact matching
			-- 	override_generic_sorter = true, -- override the generic sorter
			-- 	override_file_sorter = true, -- override the file sorter
			-- 	case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- 	-- the default case_mode is "smart_case"
			-- },
			file_browser = {
				theme = "ivy",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				mappings = {
					["i"] = {
						-- your custom insert mode mappings
					},
					["n"] = {
						-- your custom normal mode mappings
					},
				},
			},
		},
	},

	keys = {
		{ "<leader>ff", builtin.find_files, {} },
		{ "<leader>lg", builtin.live_grep, {} },
		{ "<leader>fb", builtin.buffers, {} },
		{ "<leader>fh", builtin.help_tags, {} },
		{ "<leader>gff", builtin.git_files, {} },
		{ "<leader>fg", builtin.grep_string, {} },
		{ "<leader>fr", builtin.old_files, {} },
		{ "<leader>ft", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {} },
		{ "<leader>ftb", ":Telescope file_browser<CR>", {} },
		-- $env:Path += ";$(Get-Location)"
		{
			"<leader>fs",
			function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end,
		},
	},

	config = function()
		-- require("telescope").load_extension("fzf")
		require("telescope").load_extension("file_browser")
		-- require("tokyonight").setup({
		--     on_highlights = function(hl, c)
		--         local prompt = "#2d3149"
		--         hl.TelescopeNormal = {
		--             bg = c.bg_dark,
		--             fg = c.fg_dark,
		--         }
		--         hl.TelescopeBorder = {
		--             bg = c.bg_dark,
		--             fg = c.bg_dark,
		--         }
		--         hl.TelescopePromptNormal = {
		--             bg = prompt,
		--         }
		--         hl.TelescopePromptBorder = {
		--             bg = prompt,
		--             fg = prompt,
		--         }
		--         hl.TelescopePromptTitle = {
		--             bg = prompt,
		--             fg = prompt,
		--         }
		--         hl.TelescopePreviewTitle = {
		--             bg = c.bg_dark,
		--             fg = c.bg_dark,
		--         }
		--         hl.TelescopeResultsTitle = {
		--             bg = c.bg_dark,
		--             fg = c.bg_dark,
		--         }
		--     end,
		-- })
	end,
}
