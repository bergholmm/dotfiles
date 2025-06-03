return {
  { "datsfilipe/vesper.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "catppuccin/nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              directoryFilters = {
                "-**/bazel-bin",
                "-**/bazel-out",
                "-**/bazel-src",
                "-**/bazel-testlogs",
                "-**/node_modules",
              },
              semanticTokens = true,
            },
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "buffer" },
      },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      on_attach = function()
        require("scrollbar.handlers.gitsigns").setup()
      end,
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      fzf_opts = {
        ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
      },
      oldfiles = {
        include_current_session = true,
        winopts = { preview = { layout = "vertical" } },
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
      grep = {
        rg_glob = true, -- enable glob parsing
        glob_flag = "--iglob", -- case insensitive globs
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
      },
    },
  },
}
