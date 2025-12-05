return {
    {
        'williamboman/mason.nvim',
        build = ":MasonUpdate",
        config = true
    },

    -- mason-lspconfig.lua
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig'
        },
        opts = { automatic_installation = true }
    },

    -- mason-tool-installer.lua
    -- used for conform.lua(formatter) and lsp.lua
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
        opts = {
            ensure_installed = {
                -- LSPs
                "lua-language-server",
                "typescript-language-server",
                "pyright",
                "jsonls",
                "html",
                "cssls",
                "bashls",
                "clangd",
                "marksman",

                -- Formatters
                "stylua",
                "prettier",
                "black",
                "clang-format",

                -- Linters
                "eslint_d",
                "flake8",
                "shellcheck",
                "eslint",
            },
            auto_update = true,
            run_on_start = true,
        },
        integrations = {
            ['mason-lspconfig'] = true,
            ['mason-null-ls'] = true,
            ['mason-nvim-dap'] = false,
        },
    }
}
