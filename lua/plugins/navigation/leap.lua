local opts_leap = {
	case_sensitive = false,
	equivalence_classes = { " \t\r\n" },
	max_phase_one_targets = nil,
	highlight_unlabeled_phase_one_targets = false,
	max_highlighted_traversal_targets = 10,
	substitute_chars = {},
	safe_labels = "sfnut/SFNLHMUGTZ?",
	labels = "sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?",
	special_keys = {
		next_target = "<enter>",
		prev_target = "<tab>",
		next_group = "<space>",
		prev_group = "<sab>",
	},
}

local opts_flit = {
	keys = { f = "f", F = "F", t = "t", T = "T" },
	-- A string like "nv", "nvo", "o", etc.
	labeled_modes = "v",
	clever_repeat = true,
	multiline = true,
	-- Like `leap`s similar argument (call-specific overrides).
	-- E.g.: opts = { equivalence_classes = {} }
	opts = {},
}

return {
	{
		"ggandor/leap.nvim",
		dependencies = {
			"tpope/vim-repeat",
		},
		opts = opts_leap,
		event = "BufEnter",
		config = function()
			require("leap").create_default_mappings()
			-- Use the traversal keys to repeat the previous motion without explicitly
			-- invoking Leap.
			require("leap.user").set_repeat_keys("<enter>", "<backspace>")
		end,

		keys = {
			{
				"gS",
				function()
					require("leap.remote").action()
				end,
				desc = "spooky actions at a distance",
			},
		},
	},
	{
		"ggandor/flit.nvim",
		event = "BufEnter",
		dependencies = {
			"ggandor/leap.nvim",
		},
		opts = opts_flit,
	},
}
