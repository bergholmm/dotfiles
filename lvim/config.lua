-- windwp/nvim-spectre
-- windwp/nvim-ts-autotag
-- metakirby5/codi.vim
-- npxbr/glow.nvim
-- ethanholz/nvim-lastplace
-- lukas-reineke/headlines.nvim


lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "nord"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
lvim.keys.normal_mode["ge"] = "<cmd>lua vim.diagnostic.open_float()<CR>"
lvim.keys.normal_mode["gp"] = '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>'
lvim.keys.normal_mode["gn"] = '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>'
lvim.keys.normal_mode["<leader>gb"] = '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
lvim.keys.visual_mode["<leader>gb"] = '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
lvim.lsp.buffer_mappings.normal_mode["gr"] = { '<cmd>Telescope lsp_references theme=dropdown<cr>', 'Goto references' }
lvim.lsp.buffer_mappings.normal_mode["gd"] = { '<cmd>Telescope lsp_definitions theme=dropdown<cr>', 'Goto definition' }
lvim.keys.normal_mode["<leader><space>"] = ":StripWhitespace <CR>"
lvim.keys.normal_mode["<S-Tab>"] = { '<cmd>BufferLineCyclePrev<cr>' }
lvim.keys.normal_mode["<Tab>"] = { '<cmd>BufferLineCycleNext<cr>' }
lvim.keys.normal_mode["<C-CR>"] = { '<cmd>Copilot panel<CR>' }

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- which-key
lvim.builtin.which_key.mappings["/"] = {}
lvim.builtin.which_key.mappings[";"] = {}
lvim.builtin.which_key.mappings["q"] = {}
lvim.builtin.which_key.mappings["w"] = {}
lvim.builtin.which_key.mappings["f"] = {}
lvim.builtin.which_key.mappings["s"] = {}

lvim.builtin.which_key.mappings["q"] = { "<cmd>Telescope buffers<cr>", "Find" }
lvim.builtin.which_key.mappings["t"] = { '<cmd>NvimTreeToggle<cr>', 'Toggle explorer' }
lvim.builtin.which_key.mappings["e"] = { '<cmd>NvimTreeFindFile<cr>', 'Find File Explorer' }
lvim.builtin.which_key.mappings["a"] = { "<cmd>Alpha<CR>", "Alpha" }
lvim.builtin.which_key.mappings["v"] = { "<cmd>vsplit<CR>", "Open vertical split" }
lvim.builtin.which_key.mappings["s"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
lvim.builtin.which_key.mappings["r"] = {
  name = "+Terminal",
  n = { '<cmd>lua _NODE_TOGGLE()<cr>', 'Node' },
  u = { '<cmd>lua _NCDU_TOGGLE()<cr>', 'NCDU' },
  t = { '<cmd>lua _HTOP_TOGGLE()<cr>', 'Htop' },
  p = { '<cmd>lua _PYTHON_TOGGLE()<cr>', 'Python' },
  f = { '<cmd>ToggleTerm direction=float<cr>', 'Float' },
  h = { '<cmd>ToggleTerm size=10 direction=horizontal<cr>', 'Horizontal' },
  v = { '<cmd>ToggleTerm size=80 direction=vertical<cr>', 'Vertical' },
}
lvim.builtin.which_key.mappings["f"] = {
  name = "Search",
  b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
  f = { "<cmd>Telescope find_files<cr>", "Find File" },
  h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
  H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
  M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  R = { "<cmd>Telescope registers<cr>", "Registers" },
  t = { "<cmd>Telescope live_grep<cr>", "Text" },
  k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  C = { "<cmd>Telescope commands<cr>", "Commands" },
  d = { "<cmd>Telescope dir find_files<CR>", "Find file in directory" },
  D = { "<cmd>Telescope dir live_grep<CR>", "Find text in directory" },
  p = {
    "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
    "Colorscheme with Preview",
  }
}

lvim.builtin.which_key.mappings["o"] = {
  name = "Debug",
  t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
  c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
  d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
  g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
  i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
  o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
  u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
  r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
  s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
  q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
  U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
}

-- plugin settings
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.width = 35

lvim.builtin.treesitter.ensure_installed = "all"
lvim.builtin.treesitter.ignore_install = { "haskell", 'phpdoc', 'tree-sitter-phpdoc' }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings
lvim.lsp.installer.setup.ensure_installed = {
  "sumneko_lua",
  "jsonls",
  'rust_analyzer',
  'bashls',
  'cssls',
  'gopls',
  'html',
  'lemminx',
  'prosemd_lsp',
  'tailwindcss',
  'tsserver',
  'yamlls',
}

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  { command = "prettier" },
  { command = "gofumpt" }
}

-- linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  { command = "shellcheck", extra_args = { "--severity", "warning" } },
  { command = "codespell", filetypes = { "javascript", "python" } },
  { command = "eslint_d" }
}

-- additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup({ keys = 'etovxqpdygfblzhckisuran' })
      vim.api.nvim_set_keymap("n", "s", ":HopWord<cr>", { silent = true })
    end,
  },
  { 'shaunsingh/nord.nvim' },
  {
    'princejoogie/dir-telescope.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('dir-telescope').setup({
        hidden = true,
        respect_gitignore = true,
      })
    end,
  },
  { 'mg979/vim-visual-multi' },
  { 'christoomey/vim-sort-motion' },
  { 'godlygeek/tabular' },
  {
    'ntpeters/vim-better-whitespace',
    event = 'BufRead',
    opt = true,
  },
  { 'ygm2/rooter.nvim' },
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require('gitlinker').setup()
    end,
  },
  {
    'kylechui/nvim-surround',
    tag = '*',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  { "github/copilot.vim" },
  -- { "hrsh7th/cmp-copilot" },
  -- {
  --   "kwkarlwang/bufresize.nvim",
  --   config = function()
  --     local opts = { noremap = true, silent = true }
  --     require("bufresize").setup({
  --       register = {
  --         keys = {
  --           { "n", "<leader>w<", "30<C-w><", opts },
  --           { "n", "<leader>w>", "30<C-w>>", opts },
  --           { "n", "<leader>w+", "10<C-w>+", opts },
  --           { "n", "<leader>w-", "10<C-w>-", opts },
  --           { "n", "<leader>w_", "<C-w>_", opts },
  --           { "n", "<leader>w=", "<C-w>=", opts },
  --           { "n", "<leader>w|", "<C-w>|", opts },
  --           { "n", "<leader>wo", "<C-w>|<C-w>_", opts },
  --         },
  --         trigger_events = { "BufWinEnter", "WinEnter" },
  --       },
  --       resize = {
  --         keys = {},
  --         trigger_events = { "VimResized" },
  --         increment = 5,
  --       },
  --     })
  --   end,
  -- }
}

-- additional plugin settings

-- theme
local ok, nord = pcall(require, 'nord')
if ok then
  vim.g.nord_borders = true
  nord.set()
end

-- rooter
vim.g.rooter_pattern = {
  '.git',
  'Makefile',
  '_darcs',
  '.hg',
  '.bzr',
  '.svn',
  'node_modules',
  'CMakeLists.txt',
  'Cargo.toml',
}
vim.g.outermost_root = true

-- copilot
-- lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
-- table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("")', { expr = true, silent = true })


-- general options
vim.opt.backup = false
vim.opt.timeoutlen = 500
vim.opt.cursorline = false
vim.opt.wrap = true

-- vim.opt.smartindent = true
-- vim.opt.relativenumber = true

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
