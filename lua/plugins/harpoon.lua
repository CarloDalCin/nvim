return {
    "thePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local harpoon = require("harpoon")
        local extensions = require("harpoon.extensions")

        harpoon:setup({
            settings = {
                save_on_toggle = true,
                save_on_change = true,
                sync_on_ui_close = true,
            },
        })

        --harpoon nav interface
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end)
        vim.keymap.set("n", "<leader>he", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        vim.keymap.set("n", "<leader>hq", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        --harpoon marked files
        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)
        vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end)
        vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end)
        vim.keymap.set("n", "<leader>h8", function() harpoon:list():select(8) end)
        vim.keymap.set("n", "<leader>h9", function() harpoon:list():select(9) end)
        vim.keymap.set("n", "<leader>h0", function() harpoon:list():select(10) end)

        --nav buffer
        vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)
        vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
    end
}
