local hooks = require "core.hooks"

hooks.add("setup_mappings", function(map)
  map("n", "<leader><space>", ":StripWhitespace <CR>", opt)
  map("n", "s", ":HopWord <CR>", opt)
  map("n", "<leader>z", ":set spell!<CR>", opt)
  map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
  map("v", "<leader>fr", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
end)

hooks.add("install_plugins", function(use)
  use {
      "ntpeters/vim-better-whitespace",
      event = "BufRead",
      opt = true,
   }

  use {
     "mg979/vim-visual-multi",
     event = "BufRead",
     opt = true,
   }

  use {
    'phaazon/hop.nvim',
    event = "BufRead",
    opt = true,
    branch = 'v1',
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  use {
    "christoomey/vim-sort-motion",
    event = "BufRead",
    opt = true,
  }

  use {
    "godlygeek/tabular",
    event = "BufRead",
    opt = true,
  }

  use {
    "metakirby5/codi.vim",
    event = "BufRead",
    opt = true,
  }

  use { "williamboman/nvim-lsp-installer" }

  use {
     "jose-elias-alvarez/null-ls.nvim",
     after = "nvim-lspconfig",
     config = function()
        require("custom.plugins.null-ls").setup()
     end,
  }

  use {
    "simrat39/rust-tools.nvim",
     after = "nvim-lspconfig",
  }

  use { "mfussenegger/nvim-dap" }

  use { "lambdalisue/suda.vim" }

end)

