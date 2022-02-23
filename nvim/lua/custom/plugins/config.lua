local M = {}

-- overriding default plugin configs!
M.treesitter = {
   ensure_installed = {
      "lua",
      "vim",
      "css",
      "bash",
      "dockerfile",
      "fish",
      "go",
      "html",
      "javascript",
      "json",
      "markdown",
      "python",
      "rust",
      "scss",
      "toml",
      "typescript",
      "yaml",
   },
}

M.nvimtree = {
   git = {
      enable = true,
   },
}

return M
