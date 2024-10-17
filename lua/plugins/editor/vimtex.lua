return {
	"lervag/vimtex",
	ft = { "tex" },
	lazy = false, -- we don't want to lazy load VimTeX
    enabled = false,
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- vim.g.vimtex_callback_progpath = "C:\\tools\\neovim\\nvim-win64\\bin\\nvim.exe"
		-- vim.g.vimtex_view_general_viewer = 'okular'
		vim.g.vimtex_view_general_viewer = "SumatraPDF"
		vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"

		vim.o.foldmethod = "expr"
		vim.o.foldexpr = "vimtex#fold#level(v:lnum)"
		vim.o.foldlevel = 2
		-- vim.g.vimtex_compiler_method = {
		--     latexmk = {
		--         options = {
		--             '-xelatex',
		--             -- '-file-line-error',
		--             -- '-synctex=1',vimtexcompiler
		--             -- '-interaction=nonstopmode',
		--             -- '-shell-escape',
		--         },
		--     },
		-- }
		vim.g.vimtex_compiler_latexmk_engines = {
			_ = "-xelatex",
		}
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
				"-shell-escape",
			},
		}

		vim.g.vimtex_indent_enabled = 1

		-- Minimal lsp config
		local lspconfig = require("lspconfig")
		lspconfig.texlab.setup({})

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end,
		})

		-- vim.g.vimtex_quickfix_mode = 0
		-- vim.g.vimtex_compiler_method = 'latexmk'
		-- vim.g.vimtex_view_general_viewer = 'okular'
		-- vim.g.vimtex_compiler_latexmk_engines = {
		--     _ = '-xelatex'
		-- }
		-- vim.g.tex_comment_nospell = 1
		-- vim.g.vimtex_compiler_progname = 'nvr'
		-- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
		-- vim.g.vimtex_view_general_options_latexmk = '--unique'
	end,
	-- ft =  "tex",
}
