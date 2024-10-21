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
    "nvimdev/dashboard-nvim",
    opts = {
      theme = "hyper",
      hide = {},
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          -- {
          --   desc = " Apps",
          --   group = "DiagnosticHint",
          --   action = "Telescope app",
          --   key = "a",
          -- },
          -- {
          --   desc = " dotfiles",
          --   group = "Number",
          --   action = "Telescope dotfiles",
          --   key = "d",
          -- },
        },
        { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
        disable_move = true,
        packages = { enable = false },
        footer = {},
      },
    },
  },
}
