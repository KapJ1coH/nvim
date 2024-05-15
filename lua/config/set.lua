-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- fat cursor in norman and thin in insert
--
vim.opt.guicursor = "n:block,i:ver25"

-- autoindent and such
-- Enable file type detection and plugin
vim.cmd('filetype plugin indent on')

-- Set auto-indent options
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 4       -- Number of spaces that a <Tab> counts for
vim.o.shiftwidth = 4    -- Number of spaces to use for each step of (auto)indent
vim.o.expandtab = true  -- Convert tabs to spaces
vim.o.softtabstop = 4

vim.opt.smartindent = true



vim.opt.nu = true
vim.opt.relativenumber = true

vim.g['tex_flavor'] = 'latex'


vim.cmd([[colorscheme tokyonight]])


vim.opt.modifiable = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("USERPROFILE") .. "/AppData/Local/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""
-- vim.opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s"

vim.opt.modifiable = true

vim.diagnostic.config({
	virtual_text = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false,
})

vim.keymap.set("n", "<leader>i", vim.diagnostic.open_float)
