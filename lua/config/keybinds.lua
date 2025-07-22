local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- moves lines
set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)

set({ "v", "n" }, "<leader>d", '"_d', opts)
set("i", "jj", "<Esc>")
set("n", "<Esc>", ":nohl<CR>", { silent = true })
set("n", "<C-c>", ":nohl<CR>", { silent = true })

-- wrapping keymaps
set("n", "k", "gk", opts)
set("n", "j", "gj", opts)

set("n", "U", "<C-R>", { desc = "Redo" })
-- set("n", "<leader>e", ":Explore<CR>")
-- set("n", "<leader>f", ":find ")
