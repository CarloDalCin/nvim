return {
    -- Mini nvim
    { "echasnovski/mini.nvim", version = false },

    -- coments
    {
        "echasnovski/mini.comment",
        version = false,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
            require("mini.comment").setup {
                options = {
                    custom_commentstring = function()
                        return require('ts_context_commentstring.internal')
                            .calculate_commentstring({ key = 'commentstring' })
                            or vim.bo.commentstring
                    end
                }
            }
        end
    },

    -- pairing
    {
        "echasnovski/mini.pairs",
        event = "InsertEnter",
        config = function()
            require("mini.pairs").setup()
        end,
    },

    -- surround
    {
        "echasnovski/mini.surround",
        version = false, -- usa sempre la versione più recente
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup({
                mappings = {
                    add = "ys",     -- Aggiungi
                    delete = "ds",  -- Rimuovi
                    replace = "cs", -- Sostituisci
                    find = "",      -- disattiva se non ti servono
                    find_left = "",
                    highlight = "",
                    update_n_lines = "",
                },
            })
        end,
    }
}
