return {
  { "sainnhe/gruvbox-material" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.o.background = "dark" -- or "light" for light mode
        vim.cmd("let g:gruvbox_material_background='medium'")
        vim.cmd("let g:gruvbox_material_diagnostic_line_highlight=1")
        vim.cmd("let g:gruvbox_material_diagnostic_virtual_text='colored'")
        vim.cmd("let g:gruvbox_material_enable_bold=1")
        vim.cmd("let g:gruvbox_material_enable_italic=1")
        vim.cmd([[colorscheme gruvbox-material]])
        -- changing bg and border colors
        vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
        vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
        vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "Normal" })
      end,
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
      keymap = { preset = "super-tab" },
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
}
