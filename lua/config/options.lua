-- basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
-- vim.opt.virtualedit = "all"
vim.opt.inccommand = "split"
vim.geditorconfig = true

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- visual settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.guicursor = ""
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumheight = 10
vim.opt.background = "dark"
-- require("current-theme")
vim.opt.fillchars:append({ eob = '~' })

-- file
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.autoread = true
vim.opt.autowrite = false

-- behavior settings
vim.opt.errorbells = false
vim.opt.backspace = { "indent", "start", "eol" }
vim.opt.path:append("**")
vim.opt.clipboard:append("unnamedplus")
vim.opt.mouse = "a"
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"
vim.g.manpager = "nvim +Man!"


-- file type
-- Assembly
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "asm", "nasm", "s", "S" },
    callback = function()
        vim.opt_local.tabstop = 8
        vim.opt_local.shiftwidth = 8
        vim.opt_local.softtabstop = 8
        vim.opt_local.expandtab = false
    end,
})

-- Makefile
vim.api.nvim_create_autocmd("FileType", {
    pattern = "make",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 8
        vim.opt_local.shiftwidth = 8
        vim.opt_local.softtabstop = 0
    end,
})

--
