local llm_api = vim.env.LLM_KEY

return {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip',
        'onsails/lspkind.nvim',
        "Kurama622/llm.nvim",
    },
    opts = {
        keymap = { preset = 'default' },
        appearance = {
            nerd_font_variant = vim.g.have_nerd_font and 'mono' or "",
        },
        completion = {
            trigger = {
                prefetch_on_insert = false,
                show_on_blocked_trigger_characters = {}, -- puoi aggiungere ' ', '.', '=' se vuoi
            },
            documentation = { auto_show = true },
            ghost_text = {
                enabled = true,
                show_with_menu = true,
            },
            menu = {
                auto_show = true,
                scrollbar = false,
                draw = {
                    columns = {
                        { 'label', 'label_description', gap = 1 },
                        { 'kind' },
                    },
                },
            },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'llm', 'buffer', 'dadbod' },
            providers = {
                lsp = {
                    name = 'lsp',
                    enabled = true,
                    module = 'blink.cmp.sources.lsp',
                    score_offset = 1000,
                },
                llm = {
                    name = 'llm',
                    module = "llm.common.completion.frontends.blink",
                    timeout_ms = 10000,
                    score_offset = 980,
                    async = true,
                    enabled = (llm_api and llm_api ~= "") and true or false
                },
                snippets = {
                    name = 'snippets',
                    enabled = true,
                    module = 'blink.cmp.sources.snippets',
                    score_offset = 900,
                },
                dadbod = {
                    name = 'Dadbod',
                    module = 'vim_dadbod_completion.blink',
                    score_offset = 950,
                },
            },
        },
        snippets = { preset = 'luasnip', },
        cmdline = {
            keymap = { preset = 'inherit' },
            completion = {
                ghost_text = { enabled = false },
                menu = { auto_show = true },
            },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
}
