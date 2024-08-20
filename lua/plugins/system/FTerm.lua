-- vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
-- vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
local shell
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	shell = "pwsh"
elseif vim.fn.has("unix") == 1 then
	shell = "fish"
end

local function is_floating_window_open()
	for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			return true
		end
	end
	return false
end

return {
	"numToStr/FTerm.nvim",
	opts = {
		cmd = shell,
		border = "double",
		dimensions = {
			height = 0.9,
			width = 0.9,
		},
	},
	keys = {
		{
			"<leader>t",
			mode = "n",
			function()
				require("FTerm").toggle()
			end,
		},
		{
			"C-t",
			mode = "t",
			function()
				require("FTerm").toggle()
			end,
		},
	},
}
