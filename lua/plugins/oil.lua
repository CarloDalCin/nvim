return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            columns = {},
            keymaps = {
                ["<Esc>"] = "actions.close",
            },
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
            },
            skip_confirm_for_simple_edits = true,
        })

        vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            callback = function()
                vim.opt_local.cursorline = true
                vim.keymap.set("n", "q", require("oil").close)
            end,
        })
    end
}
