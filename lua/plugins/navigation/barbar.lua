return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	lazy = false,
	-- init = function() vim.g.barbar_auto_setup = false end,
    --

    opts = {
        animation = true,
        maximum_length = 70,
        preset = 'default',
    },

	keys = {
		-- Move to previous/next
		{ "<C-S-Left>", "<Cmd>BufferPrevious<CR>" },
		{ "<C-S-Right>", "<Cmd>BufferNext<CR>" },

		-- Re-order to previous/next
		{ "<leader><", "<Cmd>BufferMovePrevious<CR>" },
		{ "<leader>>", "<Cmd>BufferMoveNext<CR>" },

		-- Goto buffer in position...
		{ "<leader>1", "<Cmd>BufferGoto 1<CR>" },
		{ "<leader>2", "<Cmd>BufferGoto 2<CR>" },
		{ "<leader>3", "<Cmd>BufferGoto 3<CR>" },
		{ "<leader>4", "<Cmd>BufferGoto 4<CR>" },
		{ "<leader>5", "<Cmd>BufferGoto 5<CR>" },
		{ "<leader>6", "<Cmd>BufferGoto 6<CR>" },
		{ "<leader>7", "<Cmd>BufferGoto 7<CR>" },
		{ "<leader>8", "<Cmd>BufferGoto 8<CR>" },
		{ "<leader>9", "<Cmd>BufferGoto 9<CR>" },
		{ "<leader>0", "<Cmd>BufferLast<CR>" },

		-- Pin/unpin buffer
		{ "<leader>bp", "<Cmd>BufferPin<CR>" },

		-- Close buffer
		{ "<leader>bc", "<Cmd>BufferClose<CR>" },

		-- Magic buffer-picking mode
		{ "<C-p>", "<Cmd>BufferPick<CR>" },

		-- Sort automatically by...
		{ "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>" },
		{ "<leader>bn", "<Cmd>BufferOrderByName<CR>" },
		{ "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>" },
		{ "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>" },
		{ "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>" },
	},
}
