return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
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
}
