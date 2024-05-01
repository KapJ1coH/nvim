local sqlite3_path = vim.fn.stdpath('config') .. '\\sqlite3.dll'

return {
	"kkharji/sqlite.lua",

	config = function()
		vim.g.sqlite_clib_path = sqlite3_path
	end,
}
