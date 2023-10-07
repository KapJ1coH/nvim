
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


vim.keymap.set("n", "<leader>vpp", "<cmd>e C:/Users/ty096829/AppData/local/nvim/lua/kap/packer.lua<CR>")
vim.keymap.set("n", "<leader>vr", "<cmd>e C:/Users/ty096829/AppData/local/nvim/lua/kap/remap.lua<CR>")
vim.keymap.set("n", "<leader>vmmu", "<cmd>e C:/sarnext/mmu<CR>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
