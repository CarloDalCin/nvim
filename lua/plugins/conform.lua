return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format buffer",
        },
    },
    opts = {
        quiet = true,
        default_format_opts = {
            timeout_ms = 2000,
            async = true,
            quiet = true,
            lsp_format = "fallback",
        },
        format_on_save = {
            async = false,
            quiet = true,
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            fish = { "fish_indent" },
            sh = { "shfmt" },
            -- ....
        },
        formatters = {
            injected = { options = { ignore_errors = true, }, },
            -- esempi personalizzati
            -- dprint = {
            --   condition = function(ctx)
            --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
            --   end,
            -- },
            -- shfmt = {
            --   prepend_args = { "-i", "2", "-ci" },
            -- },
        },
    },
    config = function(_, opts)
        require("conform").setup(opts)
    end,
}
