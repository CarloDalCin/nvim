return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        -- Definisci i linter per ogni filetype
        local lint = require('lint')
        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
        local eslint = lint.linters.eslint_d

        lint.linters_by_ft = {
            javascript = eslint,
            typescript = eslint,
            typescriptreact = eslint,
            html = lint.linters.html,
            css = lint.linters.stylelint,
            scss = lint.linters.stylelint,
            json = lint.linters.json,
            yaml = lint.linters.yaml,
            markdown = lint.linters.markdown,
            vue = lint.linters.eslint_d,
        }

        eslint.args = {
            "--no-warn-ingnored",
            "format",
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
