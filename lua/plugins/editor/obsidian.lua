vim.opt.conceallevel = 1

return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    opts = {
        legacy_commands = false,

        ------------------------------------------------------------------
        -- 📂 WORKSPACES
        ------------------------------------------------------------------
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/My Vault/",
            },
            {
                name = "buf-parent",
                path = function()
                    return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
                end,
                overrides = {
                    notes_subdir = vim.NIL,
                    new_notes_location = "current_dir",
                    templates = { folder = vim.NIL },
                    disable_frontmatter = true,
                },
            },
        },

        ------------------------------------------------------------------
        -- 📁 STRUCTURE
        ------------------------------------------------------------------
        notes_subdir = "notes",
        new_notes_location = "notes_subdir",

        ------------------------------------------------------------------
        -- 🧠 UX
        ------------------------------------------------------------------
        open_notes_in = "vsplit",

        ------------------------------------------------------------------
        -- ⚡ COMPLETION (fix for blink.cmp)
        ------------------------------------------------------------------
        completion = {
            nvim_cmp = false,
            blink_cmp = false,
        },

        ------------------------------------------------------------------
        -- 📅 DAILY NOTES
        ------------------------------------------------------------------
        daily_notes = {
            folder = "notes/dailies",
            date_format = "%Y-%m-%d",
            alias_format = "%B %-d, %Y",
            default_tags = { "daily" },
        },

        ------------------------------------------------------------------
        -- 🧾 TEMPLATES
        ------------------------------------------------------------------
        templates = {
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
        },

        ------------------------------------------------------------------
        -- 🔗 LINKS (modern API)
        ------------------------------------------------------------------
        link = {
            style = "wiki",
        },

        ------------------------------------------------------------------
        -- 🧠 NAMING
        ------------------------------------------------------------------
        note_id_func = function(title)
            if title ~= nil then
                return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                return tostring(os.time())
            end
        end,

        ------------------------------------------------------------------
        -- 📎 ATTACHMENTS (updated API)
        ------------------------------------------------------------------
        attachments = {
            folder = "assets/imgs",
        },

        ------------------------------------------------------------------
        -- 📊 SEARCH (updated API)
        ------------------------------------------------------------------
        search = {
            sort_by = "modified",
            sort_reversed = true,
        },

        ------------------------------------------------------------------
        -- 🎨 UI
        ------------------------------------------------------------------
        ui = {
            enable = true,
        },

        ------------------------------------------------------------------
        -- 🧪 LOGGING
        ------------------------------------------------------------------
        log_level = vim.log.levels.INFO,
    },

    ----------------------------------------------------------------------
    -- ⌨️ GLOBAL KEYMAPS
    ----------------------------------------------------------------------
    keys = {
        { "<leader>oo", "<cmd>ObsidianOpen<CR>",              desc = "Obsidian: Open app" },
        { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>",       desc = "Quick switch" },
        { "<leader>os", "<cmd>ObsidianSearch<CR>",            desc = "Search notes" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<CR>",         desc = "Backlinks" },
        { "<leader>ol", "<cmd>ObsidianLinks<CR>",             desc = "Links in note" },

        { "<leader>on", "<cmd>ObsidianNew<CR>",               desc = "New note" },
        { "<leader>ot", "<cmd>ObsidianToday<CR>",             desc = "Today note" },
        { "<leader>oy", "<cmd>ObsidianYesterday<CR>",         desc = "Yesterday note" },
        { "<leader>oT", "<cmd>ObsidianTomorrow<CR>",          desc = "Tomorrow note" },
        { "<leader>od", "<cmd>ObsidianDailies<CR>",           desc = "Dailies" },

        { "<leader>or", "<cmd>ObsidianRename<CR>",            desc = "Rename note" },
        { "<leader>oe", "<cmd>ObsidianExtractNote<CR>",       mode = "v",                   desc = "Extract note" },

        { "<leader>oN", "<cmd>ObsidianNewFromTemplate<CR>",   desc = "New from template" },
        { "<leader>oI", "<cmd>ObsidianTemplate<CR>",          desc = "Insert template" },

        { "<leader>op", "<cmd>ObsidianPasteImg<CR>",          desc = "Paste image" },
        { "<leader>oC", "<cmd>ObsidianTOC<CR>",               desc = "Table of contents" },

        { "<leader>ov", "<cmd>ObsidianFollowLink vsplit<CR>", desc = "Follow link (vsplit)" },
        { "<leader>oh", "<cmd>ObsidianFollowLink hsplit<CR>", desc = "Follow link (hsplit)" },

    },
}
