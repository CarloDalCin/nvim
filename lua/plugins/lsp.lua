local server_opts = {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    },
}

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'saghen/blink.cmp',
    },
    config = function()
        local lspconfig = require('lspconfig')
        local mason_lspconfig = require('mason-lspconfig')

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

        for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
            local opts = server_opts[server_name] or {}
            opts.capabilities = capabilities
            lspconfig[server_name].setup(opts)
        end


        -- keybinds --
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local set = vim.keymap.set
                local opts = { buffer = event.buf, noremap = true, silent = true }


                -- Vai alla definizione
                set("n", "gd", vim.lsp.buf.definition, opts)

                -- Vai alla dichiarazione (es. tipo o variabile globale)
                set("n", "gD", vim.lsp.buf.declaration, opts)

                -- Hover (tooltip info)
                set("n", "K", vim.lsp.buf.hover, opts)

                -- Firma funzione
                set("n", "gs", vim.lsp.buf.signature_help, opts)

                -- Implementazione (Go to Implementation)
                set("n", "gi", vim.lsp.buf.implementation, opts)

                -- Tipo (Go to Type Definition)
                set("n", "gt", vim.lsp.buf.type_definition, opts)

                -- Rinomina simbolo
                set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                -- Code Action (refactoring, import, ecc.)
                set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

                -- Lista di riferimenti (es. tutte le occorrenze)
                set("n", "gr", vim.lsp.buf.references, opts)

                -- conform is used instead of lsp for formatting
                -- set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
                set("n", "[d", vim.diagnostic.goto_prev, opts)
                set("n", "]d", vim.diagnostic.goto_next, opts)
                set("n", "<leader>of", vim.diagnostic.open_float, opts)
                set("n", "<leader>q", vim.diagnostic.setloclist, opts)
            end
        })
    end,
}
