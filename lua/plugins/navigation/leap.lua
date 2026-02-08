local opts_leap = {
    case_sensitive = false,
    equivalence_classes = { " \t\r\n" },
    max_phase_one_targets = nil,
    highlight_unlabeled_phase_one_targets = false,
    max_highlighted_traversal_targets = 10,
    substitute_chars = {},
    safe_labels = "sfnut/SFNLHMUGTZ?",
    labels = "sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?",
    special_keys = {
        next_target = "<enter>",
        prev_target = "<tab>",
        next_group = "<space>",
        prev_group = "<sab>",
    },
}

local opts_flit = {
    keys = { f = "f", F = "F", t = "t", T = "T" },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = "v",
    clever_repeat = true,
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {},
}

local function add_default_mappings(force_3f)
    for _, _22_ in ipairs({ { { "n", "x", "o" }, "s", "<Plug>(leap-forward)", "Leap forward" }, { { "n", "x", "o" }, "S", "<Plug>(leap-backward)", "Leap backward" }, { { "x", "o" }, "x", "<Plug>(leap-forward-till)", "Leap forward till" }, { { "x", "o" }, "X", "<Plug>(leap-backward-till)", "Leap backward till" }, { { "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", "Leap from window" } }) do
        local modes = _22_[1]
        local lhs = _22_[2]
        local rhs = _22_[3]
        local desc = _22_[4]
        for _0, mode in ipairs(modes) do
            if (force_3f or ((vim.fn.mapcheck(lhs, mode) == "") and (vim.fn.hasmapto(rhs, mode) == 0))) then
                vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
            else
            end
        end
    end
    return nil
end


return {
    {
        url = "https://codeberg.org/andyg/leap.nvim",
        dependencies = {
            "tpope/vim-repeat",
        },

        opts = opts_leap,
        event = "BufEnter",
        config = function()
            add_default_mappings(true)
            -- Use the traversal keys to repeat the previous motion without explicitly
            -- invoking Leap.
            require("leap.user").set_repeat_keys("<enter>", "<backspace>")
        end,

        keys = {
            {
                "gS",
                function()
                    require("leap.remote").action()
                end,
                desc = "spooky actions at a distance",
            },
        },
    },
    {
        "ggandor/flit.nvim",
        event = "BufEnter",
        dependencies = {
            url = "https://codeberg.org/andyg/leap.nvim",
            -- "ggandor/leap.nvim",
        },
        opts = opts_flit,
    },
}
