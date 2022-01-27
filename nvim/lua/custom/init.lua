local map = require("core.utils").map
local customPlugins = require "core.customPlugins"

-- Custom mappings
map("n", "<leader><space>", ":StripWhitespace <CR>")
map("n", "s", ":HopWord <CR>")
map("n", "<leader>z", ":set spell!<CR>")
map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("v", "<leader>fr", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "<C-S-Left>", ":vertical resize -1 <CR>")
map("n", "<C-S-Right>", ":vertical resize +1 <CR>")
map("n", "<C-S-Up>", ":resize +1 <CR>")
map("n", "<C-S-Down>", ":resize -1 <CR>")

-- Custom plugins
customPlugins.add(function(use)
 use {
      "williamboman/nvim-lsp-installer",
      config = function()
         require "custom.plugins.lspconfig"
      end,

      -- lazy load!
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lsp-installer"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
      opt = true,
   }

   use {
      "neovim/nvim-lspconfig",
      module = "lspconfig",
      after = "nvim-lsp-installer",
   }

   use {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.signature"
      end,
   }


      -- load luasnips + cmp related in insert mode only
    use {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
         require "custom.plugins.cmp"
      end,
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         local luasnip = require "luasnip"
         luasnip.config.set_config {
            history = true,
            updateevents = "TextChanged,TextChangedI",
         }
         require("luasnip/loaders/from_vscode").load()
      end,
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
   }

   use {
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
   }

   use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
         local autopairs = require "nvim-autopairs"
         local cmp_autopairs = require "nvim-autopairs.completion.cmp"

         autopairs.setup { fast_wrap = {} }

         local cmp = require "cmp"
         cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
   }

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

