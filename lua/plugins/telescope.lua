local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        -- {
        -- 	"nvim-telescope/telescope-fzf-native.nvim",
        -- 	build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        -- },
        { "nvim-telescope/telescope-file-browser.nvim" },
    },
    lazy = false,
    opts = {
        defaults = {
            file_ignore_patterns = {
                "tags",
            },
        },
        pickers = {
            find_files = {
                find_command = { "fd" },
            },
            grep_string = {
                "rg",
            },
        },
        buffers = {
            mappings = {
                i = {
                    ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                },
            },
        },
    },

    keys = {
        { "<leader>fr",  builtin.oldfiles,    desc = "Old files",   {} },
        { "<leader>ff",  builtin.find_files,  desc = "Find files",  {} },
        { "<leader>lg",  builtin.live_grep,   desc = "Live grep",   {} },
        { "<leader>fb",  builtin.buffers,     desc = "Buffers",     {} },
        { "<leader>fh",  builtin.help_tags,   desc = "Help tags",   {} },
        { "<leader>gff", builtin.git_files,   desc = "Git files",   {} },
        { "<leader>fg",  builtin.grep_string, desc = "Grep string", {} },
    },

    config = function()
        -- require("telescope").load_extension("fzf")
        -- require("telescope").load_extension("file_browser")
        -- require("tokyonight").setup({
        --     on_highlights = function(hl, c)
        --         local prompt = "#2d3149"
        --         hl.TelescopeNormal = {
        --             bg = c.bg_dark,
        --             fg = c.fg_dark,
        --         }
        --         hl.TelescopeBorder = {
        --             bg = c.bg_dark,
        --             fg = c.bg_dark,
        --         }
        --         hl.TelescopePromptNormal = {
        --             bg = prompt,
        --         }
        --         hl.TelescopePromptBorder = {
        --             bg = prompt,
        --             fg = prompt,
        --         }
        --         hl.TelescopePromptTitle = {
        --             bg = prompt,
        --             fg = prompt,
        --         }
        --         hl.TelescopePreviewTitle = {
        --             bg = c.bg_dark,
        --             fg = c.bg_dark,
        --         }
        --         hl.TelescopeResultsTitle = {
        --             bg = c.bg_dark,
        --             fg = c.bg_dark,
        --         }
        --     end,
        -- })
    end,
}
