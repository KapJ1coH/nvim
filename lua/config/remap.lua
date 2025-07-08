local username = vim.fn.expand("$USER")
if username == "$USER" then
	username = vim.fn.expand("$USERNAME")
end

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.keymap.set("v", "T", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "D", ":m '<-2<CR>gv=gv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Smart replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Visual range G command
vim.keymap.set("v", "<leader>g", [[:g/^/normal ]])

-- Search case unsensetive
vim.keymap.set("n", "/", "/\\c")

-- useful file jumps
vim.keymap.set("n", "<leader>vpp", "<cmd>e $LOCALAPPDATA/nvim/lua/config/lazy.lua<CR>")
vim.keymap.set("n", "<leader>vpl", "<cmd>e $LOCALAPPDATA/nvim/lua/plugins<CR>")
vim.keymap.set("n", "<leader>vr", "<cmd>e $LOCALAPPDATA/nvim/lua/config/remap.lua<CR>")
vim.keymap.set("n", "<leader>vn", "<cmd>e ~/Documents/notes<CR>")

if username == "timam" then
	vim.keymap.set("n", "<leader>vph", "<cmd>e $LOCALAPPDATA/nvim/lua/kap/remap.lua<CR>")
	-- vim.keymap.set("n", "<leader>vmmu", "<cmd>e C:/sarnext/mmu<CR>")
	vim.keymap.set("n", "<leader>vn", "<cmd>e ~/Documents/Notes<CR>")
elseif username == "ty096829" then
	vim.keymap.set("n", "<leader>vph", "<cmd>e C:/sarnext/mmu/project_help.py<CR>")
	vim.keymap.set("n", "<leader>vmmu", "<cmd>e C:/sarnext/mmu<CR>")
	vim.keymap.set("n", "<leader>vn", "<cmd>e C:/Users/ty096829/Documents/Notes/notes.md<CR>")
	vim.keymap.set(
		"n",
		"<leader>rg",
		[[:!python mmu_test_sw_lib\mmu_test_sw_lib\Utilities\reg_lookup\reg_lookup.py <C-r><C-w><cr>]]
	)
end

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- NOTE example on how to set reg values
-- vim.fn.setreg("t", "/send_tele\rV/decode_can_message\r/)\rdk pt")
-- vim.fn.setreg("l", "/send_long_tele\rV/decode_long_telemetry_response\r/)\rdk pl")
-- vim.fn.setreg("s", "Vy/step = \rnVpf.^")

-- potential map for replacing stuff
--
-- replaces .55 into .{step_minor}
-- "/step =\r/\.\d\+\rwcw[�kb{step_minor}Ostep_minor += 1/step =\r"

-- paste useful stuff
-- vim.keymap.set({ "n", "v" }, "<leader>pl", [[oparam_dict, _ = cf.get_long_telemetry()<ESC>]])
-- vim.keymap.set({ "n", "v" }, "<leader>pt", [[oparam_dict, _ = cf.get_telemetry()<ESC>]])

-- deleting stuff
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>dd", [["_dd]])
vim.keymap.set({ "n", "v" }, "<leader>D", [["_D]])

-- debug git push for the lab pc
vim.keymap.set("n", "gtc", ':Git commit -a -m ""<Left>')
vim.keymap.set("n", "gtp", ":Git push<CR>")

-- show the doc
vim.keymap.set("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>")
