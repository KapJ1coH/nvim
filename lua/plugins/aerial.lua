return {
	{
		"stevearc/aerial.nvim",
		lazy = false,
		-- event = "BufEnter",
		opts = function()
			local opts = {
				attach_mode = "global",
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '(' and ')'
					vim.keymap.set({ "n", "v" }, "(", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set({ "n", "v" }, ")", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
				backends = { "lsp", "treesitter", "markdown", "man" },
				show_guides = true,
				layout = {
					resize_to_content = false,
					win_opts = {
						winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
						signcolumn = "yes",
						statuscolumn = " ",
					},
				},
                -- stylua: ignore
                guides = {
                    mid_item   = "├╴",
                    last_item  = "└╴",
                    nested_top = "│ ",
                    whitespace = "  ",
                },
			}
			return opts
		end,
		keys = {
			{ "<leader>ae", "<cmd>AerialNavToggle<cr>", desc = "Aerial (Symbols)" },
		},
	},

	-- lualine integration
	--{
	--  "nvim-lualine/lualine.nvim",
	--  optional = true,
	--  opts = function(_, opts)
	--    table.insert(opts.sections.lualine_c, {
	--      "aerial",
	--      sep = " ", -- separator between symbols
	--      sep_icon = "", -- separator between icon and symbol

	--      -- The number of symbols to render top-down. In order to render only 'N' last
	--      -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
	--      -- be used in order to render only current symbol.
	--      depth = 5,

	--      -- When 'dense' mode is on, icons are not rendered near their symbols. Only
	--      -- a single icon that represents the kind of current symbol is rendered at
	--      -- the beginning of status line.
	--      dense = false,

	--      -- The separator to be used to separate symbols in dense mode.
	--      dense_sep = ".",

	--      -- Color the symbol icons.
	--      colored = true,
	--    })
	--  end,
	--},
}
