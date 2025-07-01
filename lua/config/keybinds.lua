local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- moves lines
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")
set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)

set("v", "p", '"_dp', opts)
set("i", "jj", "<Esc>")
set("n", "<Esc>", ":nohl<CR>", { silent = true })
set("n", "<C-c>", ":nohl<CR>", { silent = true })

set("n", "U", "<C-R>", { desc = "Redo" })
