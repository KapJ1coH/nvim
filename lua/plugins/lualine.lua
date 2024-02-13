-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
    blue    = '#80a0ff',
    cyan    = '#79dac8',
    black   = '#080808',
    white   = '#c6c6c6',
    red     = '#ff5189',
    violet  = '#d183e8',
    grey    = '#303030',
    innerbg = nil,
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.innerbg },
    },

    insert = { a = { fg = colors.black, bg = colors.blue } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.innerbg },
    },
}
return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        event = 'ColorScheme',
        opts = {
            options = {
                theme = bubbles_theme,
                -- theme = 'tokyonight',
                component_separators = '|',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = {
                    { 'mode', separator = { left = '' }, right_padding = 2 },
                },
                lualine_b = { 'branch', 'diff', 'diagnostics', 'filename' },
                lualine_c = {},
                -- lualine_x = {
                --     {
                --         require("lazy.status").updates,
                --         cond = require("lazy.status").has_updates,
                --         color = { fg = "#ff9e64" },
                --     },
                -- },
                lualine_x = {},
                lualine_y = { 'encoding', 'fileformat', 'filetype', 'progress' },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },
            },
            tabline = {},
            extensions = {},
        },
    },
}
