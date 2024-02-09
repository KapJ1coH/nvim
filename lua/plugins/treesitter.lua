local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        require 'nvim-treesitter.install'.prefer_git = false
        require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

        configs.setup({
            ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "ada", "cpp",
                "git_config", "git_rebase", "gitignore", "html", "java", "json", "regex", "rust" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
        })
    end
}


return { M }
