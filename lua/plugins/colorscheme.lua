---@diagnostic disable: undefined-doc-name, inject-field
local opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "night",         -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day",    -- The theme is used when the background is set to light
    transparent = true,     -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent",     -- style for sidebars, see below
        floats = "transparent",       -- style for floating windows
    },
    sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false,             -- dims inactive windows
    lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors)
        colors.comment = "#7B819C"
        colors.bg_statusline = colors.transparent
        colors.fg_gutter = "#82879C"
    end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
}
return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 2000,
    opts = opts,
}
-- local opts = {
--     --- @usage 'auto'|'main'|'moon'|'dawn'
--     variant = 'moon',
--     --- @usage 'main'|'moon'|'dawn'
--     dark_variant = 'main',
--     bold_vert_split = false,
--     dim_nc_background = false,
--     styles = {
--         bold = true,
--         italic = true,
--         transparency = true,
--     },
--
--     --- @usage string hex value or named color from rosepinetheme.com/palette
--     groups = {
--         background = 'NONE',
--         background_nc = '_experimental_nc',
--         panel = 'surface',
--         panel_nc = 'base',
--         border = 'highlight_med',
--         comment = 'subtle',
--         link = 'iris',
--         punctuation = 'subtle',
--
--         error = 'love',
--         hint = 'iris',
--         info = 'foam',
--         warn = 'gold',
--
--         headings = {
--             h1 = 'iris',
--             h2 = 'foam',
--             h3 = 'rose',
--             h4 = 'gold',
--             h5 = 'pine',
--             h6 = 'foam',
--         }
--         -- or set all headings at once
--         -- headings = 'subtle'
--     },
--
--     -- Change specific vim highlight groups
--     -- https://github.com/rose-pine/neovim/wiki/Recipes
--     highlight_groups = {
--         ColorColumn = { bg = 'rose' },
--
--         -- Blend colours against the "base" background
--         CursorLine = { bg = 'foam', blend = 10 },
--         StatusLine = { fg = 'love', bg = 'love', blend = 10 },
--
--         -- By default each group adds to the existing config.
--         -- If you only want to set what is written in this config exactly,
--         -- you can set the inherit option:
--         Search = { bg = 'gold', inherit = false },
--
--         TelescopeBorder = { fg = "highlight_high", bg = "none" },
--         TelescopeNormal = { bg = "none" },
--         TelescopePromptNormal = { bg = "base" },
--         TelescopeResultsNormal = { fg = "subtle", bg = "none" },
--         TelescopeSelection = { fg = "text", bg = "base" },
--         TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
--     },
--
-- }
-- return {
--     "rose-pine/neovim",
--     name = "rose-pine",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('rose-pine').setup(opts)
--         vim.cmd('colorscheme rose-pine')
--     end,
-- }
