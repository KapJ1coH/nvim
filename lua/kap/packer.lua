
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use { 'mhartington/formatter.nvim' }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine-moon')
        end
    })

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }

    use "stevearc/aerial.nvim"

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use "lukas-reineke/indent-blankline.nvim"

    use('mhinz/vim-startify')
    -- use('wakatime/vim-wakatime')
    -- use('jiangmiao/auto-pairs')
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use 'ThePrimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'better-defaults',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},

            {'nanotee/nvim-lsp-basics'},
            {'lukas-reineke/cmp-rg'},

        }
    }
    -- use 'tpope/vim-surround'
    -- use {
    --     "windwp/nvim-autopairs",
    --     config = function() require("nvim-autopairs").setup {} end
    -- }

    use {
        'fei6409/log-highlight.nvim',
    }

    use "folke/neodev.nvim"

    -- testing stuff
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-vim-test",
            "nvim-neotest/neotest-plenary"
        }
    }

    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    use("petertriho/nvim-scrollbar")

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = { "markdown" },
    })

    use ("folke/todo-comments.nvim")
end)

