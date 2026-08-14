return {
    {
        'milanglacier/minuet-ai.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            provider = 'openai_fim_compatible',
            n_completions = 1,
            context_window = 4000,
            throttle = 500,
            debounce = 300,
            provider_options = {
                openai_fim_compatible = {
                    api_key = 'TERM',
                    name = 'Ollama',
                    end_point = 'http://localhost:11434/v1/completions',
                    model = 'codestral:22b-v0.1-q8_0',
                    optional = {
                        max_tokens = 256,
                        top_p = 0.9,
                    },
                },
            },
            virtualtext = {
                auto_trigger_ft = {}, -- {} = manual only; use { 'rust', 'go' } for ghost text
                keymap = {
                    accept = '<A-A>',
                    accept_line = '<A-a>',
                    accept_n_lines = '<A-z>',
                    prev = '<A-[>',
                    next = '<A-]>',
                    dismiss = '<A-e>',
                },
            },
        },
    },
    {
        'Saghen/blink.cmp',
        version = '1.*',
        dependencies = { 'milanglacier/minuet-ai.nvim' },
        opts = function()
            return {
                keymap = {
                    ['<A-y>'] = require('minuet').make_blink_map(),
                },
                sources = {
                    default = { 'lsp', 'path', 'buffer', 'snippets', 'minuet' },
                    providers = {
                        minuet = {
                            name = 'minuet',
                            module = 'minuet.blink',
                            async = true,
                            timeout_ms = 3000,
                            score_offset = 50,
                        },
                    },
                },
                completion = { trigger = { prefetch_on_insert = false } },
            }
        end,
    },
}
