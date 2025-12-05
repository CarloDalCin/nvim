return {
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
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup({
                mappings = {
                    add = "ys",
                    delete = "ds",
                    replace = "cs",
                    find = "",
                    find_left = "",
                    highlight = "",
                    update_n_lines = "",
                },
                search_method = 'cover_or_next',
                respect_selection_type = true,
            })
        end,
    },

    -- move
    {
        'echasnovski/mini.move',
        version = false,
        config = function()
            require('mini.move').setup({
                mappings = {
                    -- visual
                    left = '<A-h>',
                    right = '<A-l>',
                    down = '<A-j>',
                    up = '<A-k>',
                    -- normal
                    line_left = '<A-h>',
                    line_right = '<A-l>',
                    line_down = '<A-j>',
                    line_up = '<A-k>',
                },
            })
        end
    },

    -- statusline
    {
        'echasnovski/mini.statusline',
        version = false,
        config = function()
            require('mini.statusline').setup({
                content = {
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local filename = MiniStatusline.section_filename({ trunc_width = 140 })
                        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                        local location = MiniStatusline.section_location({ trunc_width = 75 })

                        return table.concat({
                            '%#', mode_hl, '#', -- Usa i colori della modalità (NORMAL/INSERT/VISUAL)
                            ' ', mode, ' ',
                            '%#StatusLine#',    -- Torna al colore standard della statusline
                            filename,
                            '%=',               -- Allinea a destra
                            fileinfo,
                            ' ',
                            location,
                        })
                    end,
                },
                use_icons = vim.g.have_nerd_font, -- Opzionale: icone se hai un font compatibile
                set_vim_settings = true,          -- Rispetta i colori del colorscheme
            })
        end
    },

    -- splitjoin
    {
        'echasnovski/mini.splitjoin',
        version = false,
        config = function()
            require('mini.splitjoin').setup()
        end
    },

}
