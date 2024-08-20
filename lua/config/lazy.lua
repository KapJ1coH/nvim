-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- local settings = {
-- 	defaults = {
-- 		lazy = true,
-- 	},
-- 	performance = {
-- 		rtp = {
-- 			-- disable some rtp plugins
-- 			disabled_plugins = {
-- 				"gzip",
-- 				-- "matchit",
-- 				-- "matchparen",
-- 				-- "netrwPlugin",
-- 				"tarPlugin",
-- 				"tohtml",
-- 				"tutor",
-- 				"zipPlugin",
-- 			},
-- 		},
-- 	},
-- }
-- require("lazy").setup("plugins", settings)
-- TODO Remove this comment block if stuff below works

require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
		{ import = "plugins.meme" },
		{ import = "plugins.navigation" },
		{ import = "plugins.system" },
		{ import = "plugins.git" },
		{ import = "plugins.misc" },
		{ import = "plugins.editor" },
		{ import = "plugins.lsp" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
