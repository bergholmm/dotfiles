local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map("i", "<S-Tab>", "<C-d>")

map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader><Tab>", "<cmd>Telescope buffers sort_mru=true theme=dropdown<cr>", { desc = "Find buffers" })
