local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map("i", "<S-Tab>", "<C-d>")

map("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>", { desc = "Find in folder" })
map("n", "<leader>fl", "<cmd>Telescope dir find_files<CR>", { desc = "Find files in folder" })

vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>o")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")
