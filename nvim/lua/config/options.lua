vim.g.mapleader = ","

vim.opt.wrap = true
vim.opt.textwidth = 80
vim.opt.scrolloff = 999
vim.opt.swapfile = false
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.laststatus = 0
vim.opt.showcmd = false
vim.opt.showtabline = 2

-- Avoid conflicts with Prettier and Biome
vim.g.lazyvim_prettier_needs_config = true
