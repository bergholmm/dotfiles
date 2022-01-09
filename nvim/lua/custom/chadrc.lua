local M = {}
local indent = 2

-- vim options override
vim.opt.shell = "/bin/bash" -- fish is making plugins slow somehow...
vim.opt.scrolloff = 3
vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.shiftwidth = indent
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.list = true
vim.opt.listchars = {tab = '▸ ', trail = '▫'}
vim.opt.spelllang = "en"
vim.api.nvim_exec([[ autocmd FileType markdown setlocal spell ]], false)
vim.api.nvim_exec([[ autocmd FileType gitcommit setlocal spell ]], false)

--
-- vim.api_nvim_set_keymap('c', 'w!!', "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true }) " cnoremap w!! %!sudo tee > /dev/null %
--

-- nvchad options override
M.options = {
  mapleader = ",",
  relativenumber = true,
}


-- nvchad plugins override
M.plugins = {
  status = {
    dashboard = true,
  },
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },
}

-- nvchad mappings override
M.mappings = {
   misc = {
      cheatsheet = "<leader>pp",
      close_buffer = "<leader>c",
      copy_whole_file = "<leader>a", -- copy all contents of current buffer
      line_number_toggle = "<leader>pn",
      update_nvchad = "<leader>uu",
      new_buffer = "<leader>n",
      -- new_tab = "",
   }
}

-- nvchad plugin mappings override
M.mappings.plugins = {
   -- dashboard = {
   --    bookmarks = "<leader>bm",
   --    new_file = "<leader>fn", -- basically create a new buffer
   --    open = "<leader>db", -- open dashboard
   --    session_load = "<leader>l",
   --    session_save = "<leader>s",
   -- },

   lspconfig = {
      declaration = "gD",
      definition = "gd",
      hover = "K",
      implementation = "gi",
      signature_help = "gk",
      add_workspace_folder = "<leader>wa",
      remove_workspace_folder = "<leader>wr",
      list_workspace_folders = "<leader>wl",
      type_definition = "<leader>D",
      rename = "<leader>rn",
      code_action = "<leader>ca",
      references = "gr",
      float_diagnostics = "ge",
      goto_prev = "gn",
      goto_next = "gb",
      set_loclist = "<leader>q",
      formatting = "<leader>fm",
   },

   nvimtree = {
      toggle = "<leader>t",
      focus = "<leader>d",
   },

   telescope = {
      buffers = "<leader>fb",
      find_files = "<leader>ff",
      find_hiddenfiles = "<leader>fa",
      git_commits = "<leader>gc",
      git_status = "<leader>gst",
      help_tags = "<leader>fh",
      live_grep = "<leader>fr",
      oldfiles = "<leader>fo",
      themes = "<leader>ph", -- NvChad theme picker
   },
}

-- nvchad ui override
M.ui = {
   theme = "chadracula",
}

return M
