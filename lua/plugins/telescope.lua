return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        "andrew-george/telescope-themes",
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        telescope.load_extension("fzf")
        telescope.load_extension("themes")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                extensions = {
                    theme = {
                        enable_preview = true,
                        enable_libe_preview = true,
                        persist = {
                            enable = true,
                            path = vim.fn.stdpath("config") .. "lua/colorscheme.lua",
                        },
                    },
                },
            }
        })

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fG', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fg', builtin.current_buffer_fuzzy_find, { desc = 'Telescope current buffer' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope oldfiles' })
        vim.keymap.set('n', '<leader>th', "<cmd>Telescope themes<cr>", { desc = 'Telescope themes' })
        vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Telescope registers' })
        vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Telescope marks' })
        vim.keymap.set('n', '<leader>fW', builtin.grep_string, { desc = 'Telescope grep_string' })
        vim.keymap.set('n', '<leader>fw', function()
            builtin.grep_string({
                search = vim.fn.expand('<cword>'),
                search_dirs = { vim.api.nvim_buf_get_name(0) },
            })
        end, { desc = 'Telescope buffer grep_string' })
    end
}
