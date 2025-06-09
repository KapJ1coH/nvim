return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({})

		-- If you want insert `(` after select function or method item
		-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		-- local cmp = require("cmp")
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		-- local cond = require("nvim-autopairs.conds")
		-- local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" }, { "<", ">" } }
		-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        npairs.add_rules({
            Rule("*", "*", "markdown")
        })


		-- npairs.add_rules({
			-- Rule("<", ">"),

			-- -- Space after =
			-- Rule("=", "")
			-- 	:with_pair(cond.not_inside_quote())
			-- 	:with_pair(function(opts)
			-- 		local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
			-- 		if last_char:match("[%w%=%s]") then
			-- 			return true
			-- 		end
			-- 		return false
			-- 	end)
			-- 	:replace_endpair(function(opts)
			-- 		local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
			-- 		local next_char = opts.line:sub(opts.col, opts.col)
			-- 		next_char = next_char == " " and "" or " "
			-- 		if prev_2char:match("%w$") then
			-- 			return "<bs> =" .. next_char
			-- 		end
			-- 		if prev_2char:match("%=$") then
			-- 			return next_char
			-- 		end
			-- 		if prev_2char:match("=") then
			-- 			return "<bs><bs>=" .. next_char
			-- 		end
			-- 		return ""
			-- 	end)
			-- 	:set_end_pair_length(0)
			-- 	:with_move(cond.none())
			-- 	:with_del(cond.none()),

			-- -- Space between parentheses
			-- Rule(' ', ' ')
			-- -- Pair will only occur if the conditional function returns true
			--     :with_pair(function(opts)
			--         -- We are checking if we are inserting a space in (), [], {} or <>
			--         local pair = opts.line:sub(opts.col - 1, opts.col)
			--         return vim.tbl_contains({
			--             brackets[1][1] .. brackets[1][2],
			--             brackets[2][1] .. brackets[2][2],
			--             brackets[3][1] .. brackets[3][2],
			--             brackets[4][1] .. brackets[4][2],
			--         }, pair)
			--     end)
			--     :with_move(cond.none())
			--     :with_cr(cond.none())
			-- -- We only want to delete the pair of spaces when the cursor is as such: ( | )
			--     :with_del(function(opts)
			--         local col = vim.api.nvim_win_get_cursor(0)[2]
			--         local context = opts.line:sub(col - 1, col + 2)
			--         return vim.tbl_contains({
			--             brackets[1][1] .. '  ' .. brackets[1][2],
			--             brackets[2][1] .. '  ' .. brackets[2][2],
			--             brackets[3][1] .. '  ' .. brackets[3][2],
			--             brackets[4][1] .. '  ' .. brackets[4][2],
			--         }, context)
			--     end),
		-- })
	end,
}
