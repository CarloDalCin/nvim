return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        -- Definisci i linter per ogni filetype
        local lint = require('lint')
        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
        local eslint = lint.linters.eslint_d

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            html = { "html" },
            css = { "stylelint" },
            scss = { "stylelint" },
            json = { "jsonlint" },
            yaml = { "yamllint" },
            markdown = { "markdownlint" },
            vue = { "eslint_d" },
        }

        eslint.args = {
            "--no-warn-ignored",
            "--format",
            "json",
            "--stdin",
            "--stdin-filename",
            function()
                return vim.fn.expand('%:p')
            end,
        }

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end
}
