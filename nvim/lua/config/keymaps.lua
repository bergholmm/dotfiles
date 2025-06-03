local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map("i", "<S-Tab>", "<C-d>")

vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>o")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")

vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })
