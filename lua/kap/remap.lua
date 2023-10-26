
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


vim.keymap.set("v", "T", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "D", ":m '<-2<CR>gv=gv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- useful file jumps
vim.keymap.set("n", "<leader>vpp", "<cmd>e C:/Users/ty096829/AppData/local/nvim/lua/kap/packer.lua<CR>")
vim.keymap.set("n", "<leader>vpl", "<cmd>e C:/Users/ty096829/AppData/local/nvim/after/plugin<CR>")
vim.keymap.set("n", "<leader>vph", "<cmd>e C:/sarnext/mmu/project_help.py<CR>")
vim.keymap.set("n", "<leader>vr", "<cmd>e C:/Users/ty096829/AppData/local/nvim/lua/kap/remap.lua<CR>")
vim.keymap.set("n", "<leader>vmmu", "<cmd>e C:/sarnext/mmu<CR>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)


-- deleting stuff
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>dd", [["_dd]])
vim.keymap.set({"n", "v"}, "<leader>D", [["_D]])

-- paste useful stuff
vim.keymap.set({"n", "v"}, "<leader>pl", [[oparam_dict, _ = cf.get_long_telemetry()<ESC>]])
vim.keymap.set({"n", "v"}, "<leader>pt", [[oparam_dict, _ = cf.get_telemetry()<ESC>]])

-- debug git push for the lab pc
vim.keymap.set("n", "gc", ":Git commit -a -m \"\"<Left>")
vim.keymap.set("n", "gp", ":Git push<CR>")
