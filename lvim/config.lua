vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

vim.opt.backup = false
vim.opt.timeoutlen = 500
vim.opt.cursorline = false
vim.opt.wrap = true
vim.opt.textwidth = 80
vim.opt.scrolloff = 999

lvim.log.level = "info"
lvim.format_on_save.enabled = true

lvim.leader = ","
lvim.keys.normal_mode["ge"] = "<cmd>lua vim.diagnostic.open_float()<CR>"
lvim.keys.normal_mode["gp"] = '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>'
lvim.keys.normal_mode["gn"] = '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>'
lvim.keys.normal_mode["<leader>gb"] =
'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
lvim.keys.visual_mode["<leader>gb"] =
'<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
lvim.lsp.buffer_mappings.normal_mode["gr"] = { '<cmd>Telescope lsp_references theme=dropdown<cr>', 'Goto references' }
lvim.lsp.buffer_mappings.normal_mode["gd"] = { '<cmd>Telescope lsp_definitions theme=dropdown<cr>', 'Goto definition' }
lvim.keys.normal_mode["<leader><space>"] = ":StripWhitespace <CR>"
-- lvim.keys.normal_mode["<S-Tab>"] = { '<cmd>BufferLineCyclePrev<cr>' }
-- lvim.keys.normal_mode["<Tab>"] = { '<cmd>BufferLineCycleNext<cr>' }
lvim.keys.normal_mode["<S-Tab>"] = { '<cmd>bprevious<cr>' }
lvim.keys.normal_mode["<Tab>"] = { '<cmd>bnext<cr>' }
lvim.keys.normal_mode["<C-CR>"] = { '<cmd>Copilot panel<CR>' }

table.insert(lvim.builtin.project.patterns, 0, "!>packages")

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

-- lvim.builtin.which_key.mappings["<tab>"] = { "<cmd>Telescope buffers previewer=false<cr>", "List buffers" }
lvim.builtin.which_key.mappings["<tab>"] = { "<cmd>Telescope buffers sort_mru=true<cr>", "Find" }
lvim.builtin.which_key.mappings[";"] = { "<cmd>Glow<cr>", "Preview markdown" }
lvim.builtin.which_key.mappings["q"] = { "<cmd>jumps<cr>", "Jump" }
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
  l = { "<cmd>Telescope resume<cr>", "Resume last search" },
  p = {
    "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
    "Colorscheme with Preview",
  }
}

lvim.builtin.which_key.mappings["."] = {
  name = "ChatGPT",
  c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
  e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
  g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
  t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
  k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
  d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
  a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
  o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
  s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
  f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
  x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
  r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
  l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
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
lvim.builtin.alpha.mode = 'startify'
lvim.builtin.which_key.setup.plugins.registers = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.width = 35
lvim.builtin.treesitter.ensure_installed = "all"
lvim.builtin.treesitter.ignore_install = { "haskell", 'phpdoc', 'tree-sitter-phpdoc' }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.bufferline.active = true
lvim.builtin.bufferline.options = {
  indicator = {
    icon = lvim.icons.ui.BoldLineLeft, -- this should be omitted if indicator style is not 'icon'
    style = "none",                    -- can also be 'underline'|'none',
  },
  diagnostics = "none",
  diagnostics_indicator = nil,
  buffer_close_icon = nil,
  modified_icon = nil,
  close_icon = nil,
  show_buffer_icons = 'none',
  show_buffer_close_icons = 'none',
}
lvim.builtin.lualine.active = false
lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.gitsigns.on_config_done = function()
  require("scrollbar.handlers.gitsigns").setup()
end

-- generic LSP settings
lvim.lsp.installer.setup.ensure_installed = {
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
  { command = "black",      filetypes = { "python" } },
  { command = "isort",      filetypes = { "python" } },
  { command = "prettier" },
  { command = "gofumpt" },
  { command = "swiftformat" }
}

-- linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8",     filetypes = { "python" },                extra_args = { "--max-line-length", "125" } },
  { command = "shellcheck", extra_args = { "--severity", "warning" } },
  { command = "codespell",  filetypes = { "javascript", "python" } },
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
  {
    'princejoogie/dir-telescope.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
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
    lazy = true,
  },
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require('gitlinker').setup()
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          panel = {
            auto_refresh = true
          },
          suggestion = {
            auto_trigger = true,
            keymap = {
              accept = "<C-l>"
            }
          },
        })
      end, 100)
    end,
  },
  {
    'lukas-reineke/headlines.nvim',
    config = function()
      require('headlines').setup({
        markdown = {
          headline_highlights = {
            "Headline1",
            "Headline2",
            "Headline3",
            "Headline4",
            "Headline5",
            "Headline6",
          },
          codeblock_highlight = "CodeBlock",
          dash_highlight = "Dash",
          quote_highlight = "Quote",
        },
      })
    end,
  },
  {
    'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup()
    end
  },
  {
    'ellisonleao/glow.nvim',
    config = function()
      require('glow').setup()
    end
  },
  {
    "kwkarlwang/bufjump.nvim",
    config = function()
      require("bufjump").setup()
    end
  },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      -- require('hlslens').setup() is not required
      require("scrollbar.handlers.search").setup({
        -- hlslens config overrides
      })
    end,
  },
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup()

      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(conf)

      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        openai_params = {
          model = "gpt-4",
          max_tokens = 500,
        },
        popup_layout = {
          default = 'right'
        }
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}

vim.cmd [[ set laststatus=0 ]]

-- windwp/nvim-spectre
-- windwp/nvim-ts-autotag
-- metakirby5/codi.vim

local group = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env",
  group = group,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end
})
