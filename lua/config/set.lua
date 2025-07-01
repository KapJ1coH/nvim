-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- fat cursor in norman and thin in insert
--
vim.opt.guicursor = "n:block,i:ver25"

-- Highlight current line number
vim.opt.cursorline = true

-- Python
local username = vim.fn.expand('$USER')
if username == '$USER' then
    username = vim.fn.expand('$USERNAME')
end

if username == 'ty096829' then
    vim.g.python3_host_prog = "C:/Users/ty096829/AppData/Local/Programs/Python/Python311/python.exe"
else
    vim.g.python3_host_prog = "C:/Users/timam/AppData/Local/Programs/Python/Python311/python.exe"
end

-- autoindent and such
-- Enable file type detection and plugin
vim.cmd("filetype plugin indent on")

-- Set auto-indent options
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 4 -- Number of spaces that a <Tab> counts for
vim.o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.softtabstop = 4

-- Windows vs Linux
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.opt.shell = "pwsh"
	vim.opt.shellcmdflag =
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
	vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
elseif vim.fn.has("unix") == 1 then
	vim.opt.shell = "fish"
end


-- shellslash
-- vim.opt.shellslash = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.g["tex_flavor"] = "latex"

vim.cmd([[colorscheme tokyonight]])

vim.opt.modifiable = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
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

-- neovide stuff
-- vim.g.neovide_transparency = 0.8
-- vim.g.transparency = true

-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
-- vim.g.neovide_transparency = 0.8
-- vim.g.transparency = 0.8

-- vim.g.neovide_fullscreen = true

-- paste system clipboard
vim.keymap.set("n", "<C-v>", '"+p')
vim.keymap.set("i", "<C-v>", '"+p')
vim.keymap.set("v", "<C-v>", '"+p')
