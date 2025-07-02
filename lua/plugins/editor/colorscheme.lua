---@diagnostic disable: undefined-doc-name, inject-field
local opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
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
        colors.bg_statusline = "NONE"
    end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(hl, c)
        -- This is for the barbar plugin and the transparent bar.
        hl.BufferTabpageFill = {
            bg = c.transparent,
            fg = c.fg_dark,
        }

        hl.DiagnosticUnnecessary = {
            fg = "#ffcc00", -- A bright yellow; adjust as needed
        }


        local prompt = "#000000"
        hl.TelescopeNormal = {
            bg = c.transparent,
            fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
            bg = c.transparent,
            fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
            bg = c.transparent,
        }
        hl.TelescopePromptBorder = {
            bg = c.transparent,
            fg = prompt,
        }
        hl.TelescopePromptTitle = {
            bg = c.transparent,
            fg = prompt,
        }
        hl.TelescopePreviewTitle = {
            bg = c.transparent,
            fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
            bg = c.transparent,
            fg = c.bg_dark,
        }
    end,
}
return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 900,
        opts = opts,
    },
}
