return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_staus = require("lazy.status")

        lualine.setup({
            options = {
                icons_enabled = vim.g.have_nerd_font,
                theme = 'auto',
                component_separators = { left = '::', right = '::' },
                section_separators = { left = '|', right = '|' },
            },
        })
    end
}
