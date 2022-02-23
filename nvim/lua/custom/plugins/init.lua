return {
  { "williamboman/nvim-lsp-installer" }, 
  {
    "ntpeters/vim-better-whitespace",
    event = "BufRead",
    opt = true,
  },
  {
    "mg979/vim-visual-multi",
    event = "BufRead",
    opt = true,
  },
  {
    'phaazon/hop.nvim',
    event = "BufRead",
    opt = true,
    branch = 'v1',
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },
  {
    "christoomey/vim-sort-motion",
    event = "BufRead",
    opt = true,
  },
  {
    "godlygeek/tabular",
    event = "BufRead",
    opt = true,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end
  },
}