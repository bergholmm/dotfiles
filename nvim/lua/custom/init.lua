local map = require("core.utils").map

----------------------
-- Mappings (Normal)
----------------------
map("n", "<leader>z", ":set spell!<CR>")

-- Strip whitespace
map("n", "<leader><space>", ":StripWhitespace <CR>")

-- Motion
map("n", "s", ":HopWord <CR>")

-- Format buffer
map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")

-- Resize split
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

----------------------
-- Mappings (Visual)
----------------------
-- Format selection
map("v", "<leader>fr", "<cmd>lua vim.lsp.buf.formatting()<CR>")

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")
map("v", "p", '"_dP')
