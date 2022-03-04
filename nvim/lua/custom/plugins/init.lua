return {
  { "simrat39/rust-tools.nvim" },
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
  { "ygm2/rooter.nvim" },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
}
