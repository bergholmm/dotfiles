local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map("n", "<leader><space>", ":StripWhitespace <CR>", { desc = "Strip Whitespace" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader><Tab>", "<cmd>Telescope buffers sort_mru=true<cr>", { desc = "Find buffers" })

-- Mappings for GP plugin '.'
map("v", "<leader>.c", ":<C-u>'<,'>GpChatNew<cr>", { desc = "Visual Chat New" })
map("v", "<leader>.p", ":<C-u>'<,'>GpChatPaste<cr>", { desc = "Visual Chat Paste" })
map("v", "<leader>.t", ":<C-u>'<,'>GpChatToggle<cr>", { desc = "Visual Toggle Chat" })

map("v", "<leader>.<C-x>", ":<C-u>'<,'>GpChatNew split<cr>", { desc = "Visual Chat New split" })
map("v", "<leader>.<C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", { desc = "Visual Chat New vsplit" })
map("v", "<leader>.<C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", { desc = "Visual Chat New tabnew" })

map("v", "<leader>.r", ":<C-u>'<,'>GpRewrite<cr>", { desc = "Visual Rewrite" })
map("v", "<leader>.a", ":<C-u>'<,'>GpAppend<cr>", { desc = "Visual Append (after)" })
map("v", "<leader>.b", ":<C-u>'<,'>GpPrepend<cr>", { desc = "Visual Prepend (before)" })
map("v", "<leader>.i", ":<C-u>'<,'>GpImplement<cr>", { desc = "Implement selection" })

-- Nested 'g' mappings
map("v", "<leader>.gp", ":<C-u>'<,'>GpPopup<cr>", { desc = "Visual Popup" })
map("v", "<leader>.ge", ":<C-u>'<,'>GpEnew<cr>", { desc = "Visual GpEnew" })
map("v", "<leader>.gn", ":<C-u>'<,'>GpNew<cr>", { desc = "Visual GpNew" })
map("v", "<leader>.gv", ":<C-u>'<,'>GpVnew<cr>", { desc = "Visual GpVnew" })
map("v", "<leader>.gt", ":<C-u>'<,'>GpTabnew<cr>", { desc = "Visual GpTabnew" })

map("v", "<leader>.n", "<cmd>GpNextAgent<cr>", { desc = "Next Agent" })
map("v", "<leader>.s", "<cmd>GpStop<cr>", { desc = "GpStop" })
map("v", "<leader>.x", ":<C-u>'<,'>GpContext<cr>", { desc = "Visual GpContext" })

-- Nested 'w' mappings
map("v", "<leader>.ww", ":<C-u>'<,'>GpWhisper<cr>", { desc = "Whisper" })
map("v", "<leader>.wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", { desc = "Whisper Rewrite" })
map("v", "<leader>.wa", ":<C-u>'<,'>GpWhisperAppend<cr>", { desc = "Whisper Append (after)" })
map("v", "<leader>.wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", { desc = "Whisper Prepend (before)" })
map("v", "<leader>.wp", ":<C-u>'<,'>GpWhisperPopup<cr>", { desc = "Whisper Popup" })
map("v", "<leader>.we", ":<C-u>'<,'>GpWhisperEnew<cr>", { desc = "Whisper Enew" })
map("v", "<leader>.wn", ":<C-u>'<,'>GpWhisperNew<cr>", { desc = "Whisper New" })
map("v", "<leader>.wv", ":<C-u>'<,'>GpWhisperVnew<cr>", { desc = "Whisper Vnew" })
map("v", "<leader>.wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", { desc = "Whisper Tabnew" })

-- Normal mode mappings
map("n", "<leader>.c", "<cmd>GpChatNew<cr>", { desc = "New Chat" })
map("n", "<leader>.t", "<cmd>GpChatToggle<cr>", { desc = "Toggle Chat" })
map("n", "<leader>.f", "<cmd>GpChatFinder<cr>", { desc = "Chat Finder" })

map("n", "<leader>.<C-x>", "<cmd>GpChatNew split<cr>", { desc = "New Chat split" })
map("n", "<leader>.<C-v>", "<cmd>GpChatNew vsplit<cr>", { desc = "New Chat vsplit" })
map("n", "<leader>.<C-t>", "<cmd>GpChatNew tabnew<cr>", { desc = "New Chat tabnew" })

map("n", "<leader>.r", "<cmd>GpRewrite<cr>", { desc = "Inline Rewrite" })
map("n", "<leader>.a", "<cmd>GpAppend<cr>", { desc = "Append (after)" })
map("n", "<leader>.b", "<cmd>GpPrepend<cr>", { desc = "Prepend (before)" })

-- Nested 'g' mappings for Normal mode
map("n", "<leader>.gp", "<cmd>GpPopup<cr>", { desc = "Popup" })
map("n", "<leader>.ge", "<cmd>GpEnew<cr>", { desc = "GpEnew" })
map("n", "<leader>.gn", "<cmd>GpNew<cr>", { desc = "GpNew" })
map("n", "<leader>.gv", "<cmd>GpVnew<cr>", { desc = "GpVnew" })
map("n", "<leader>.gt", "<cmd>GpTabnew<cr>", { desc = "GpTabnew" })

map("n", "<leader>.n", "<cmd>GpNextAgent<cr>", { desc = "Next Agent" })
map("n", "<leader>.s", "<cmd>GpStop<cr>", { desc = "GpStop" })
map("n", "<leader>.x", "<cmd>GpContext<cr>", { desc = "Toggle GpContext" })

-- Nested 'w' mappings for Normal mode
map("n", "<leader>.ww", "<cmd>GpWhisper<cr>", { desc = "Whisper" })
map("n", "<leader>.wr", "<cmd>GpWhisperRewrite<cr>", { desc = "Whisper Inline Rewrite" })
map("n", "<leader>.wa", "<cmd>GpWhisperAppend<cr>", { desc = "Whisper Append (after)" })
map("n", "<leader>.wb", "<cmd>GpWhisperPrepend<cr>", { desc = "Whisper Prepend (before)" })
map("n", "<leader>.wp", "<cmd>GpWhisperPopup<cr>", { desc = "Whisper Popup" })
map("n", "<leader>.we", "<cmd>GpWhisperEnew<cr>", { desc = "Whisper Enew" })
map("n", "<leader>.wn", "<cmd>GpWhisperNew<cr>", { desc = "Whisper New" })
map("n", "<leader>.wv", "<cmd>GpWhisperVnew<cr>", { desc = "Whisper Vnew" })
map("n", "<leader>.wt", "<cmd>GpWhisperTabnew<cr>", { desc = "Whisper Tabnew" })

-- lvim.keys.normal_mode["<C-CR>"] = { "<cmd>Copilot panel<CR>" }
