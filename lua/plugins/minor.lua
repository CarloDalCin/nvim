return {
    -- "ojroques/vim-oscyank",
    "christoomey/vim-tmux-navigator",
    "sphamba/smear-cursor.nvim",
    {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
    },
    {
        'j-hui/fidget.nvim',
        opts = {},
    },
    {
        "joshuadanpeterson/typewriter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("typewriter").setup()
        end,
        opts = {},
    },
    {
        "folke/twilight.nvim",
        enable = false,
        event = { "BufReadPre", "BufNewFile" },
        build = ":TwilightEnable",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            treesitter = true,
            context = 8,
            dimming = { inactive = true, },
            expand = {
                "function",
                "method",
                "table",
                "block",
                "if_statement",
                "for_statement",
                "while_statement",
                "switch_statement",
            },
            exclude = {},
        },
    },
}
