return {
  { "sainnhe/gruvbox-material" },
  -- {
  --   "olivercederborg/poimandres.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("poimandres").setup({})
  --   end,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
      -- colorscheme = "poimandres",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
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
}
