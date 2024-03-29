local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

return packer.startup(function(use)
  use('wbthomason/packer.nvim')                                                               -- Have packer manage itself
  use('nvim-lua/popup.nvim')                                                                  -- An implementation of the Popup API from vim in Neovim
  use('nvim-lua/plenary.nvim')                                                                -- Useful lua functions used ny lots of plugins
  use('ChristianChiarulli/vscode-easymotion')
  use('windwp/nvim-autopairs')                                                                -- Autopairs, integrates with both cmp and treesitter
  use('numToStr/Comment.nvim')                                                                -- Easily comment stuff
  use('kyazdani42/nvim-web-devicons')                                                         --
  use('kyazdani42/nvim-tree.lua')                                                             --
  use({ 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons' }) --
  use({ 'akinsho/toggleterm.nvim', tag = 'v1.*' })                                            --
  use('moll/vim-bbye')                                                                        -- not needed
  use('nvim-lualine/lualine.nvim')                                                            --
  use('ahmedkhalf/project.nvim')                                                              --
  use('lewis6991/impatient.nvim')                                                             -- X
  use('lukas-reineke/indent-blankline.nvim')                                                  -- X
  use('goolord/alpha-nvim')                                                                   --
  use('antoinemadec/FixCursorHold.nvim')                                                      -- This is needed to fix lsp doc highlight
  use('folke/which-key.nvim')                                                                 --
  use('nathom/filetype.nvim')                                                                 -- X
  use({
    'shaunsingh/nord.nvim',                                                                   -- Colorscheme
    commit = '78f5f001709b5b321a35dcdc44549ef93185e024',
    config = function()
      vim.cmd([[colorscheme nord]])
    end,
  })
  use({
    'max397574/better-escape.nvim', -- not using
    config = function()
      require('better_escape').setup()
    end,
  })
  use({
    'princejoogie/dir-telescope.nvim',
    -- telescope.nvim is a required dependency
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('dir-telescope').setup({
        hidden = true,
        respect_gitignore = true,
      })
    end,
  })

  use('mg979/vim-visual-multi') -- X
  use({
                                -- X
    'phaazon/hop.nvim',
    branch = 'v1',              -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
    end,
  })
  use('christoomey/vim-sort-motion')  -- X
  use('godlygeek/tabular')            -- X
  use({
    'ntpeters/vim-better-whitespace', -- X
    event = 'BufRead',
    opt = true,
  })
  use('ygm2/rooter.nvim') -- X

  -- cmp plugins
  use('hrsh7th/nvim-cmp')         -- The completion plugin
  use('hrsh7th/cmp-buffer')       -- buffer completions
  use('hrsh7th/cmp-path')         -- path completions
  use('hrsh7th/cmp-cmdline')      -- X
  use('saadparwaiz1/cmp_luasnip') -- snippet completions
  use('hrsh7th/cmp-nvim-lsp')     --

  -- snippets
  use('L3MON4D3/LuaSnip')             --snippet engine
  use('rafamadriz/friendly-snippets') -- a bunch of snippets to use

  -- LSP
  use('neovim/nvim-lspconfig') -- enable LSP
  use({
    'williamboman/nvim-lsp-installer',
    commit = '3c21304',
  })                                     -- simple to use language server installer
  use('tamago324/nlsp-settings.nvim')    -- language server settings defined in json for
  use('jose-elias-alvarez/null-ls.nvim') -- for formatters and linters
  use('ray-x/lsp_signature.nvim')        -- X
  use('andymass/vim-matchup')            -- ?
  use('simrat39/rust-tools.nvim')        -- ?
  use('lukas-reineke/lsp-format.nvim')   -- X

  -- Telescope
  use('nvim-telescope/telescope.nvim') --

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter', --
    run = ':TSUpdate',
  })
  use('nvim-treesitter/nvim-treesitter-textobjects') -- X
  use('JoosepAlviste/nvim-ts-context-commentstring') --

  -- Git
  use('lewis6991/gitsigns.nvim') --
  use('tpope/vim-fugitive')      -- X
  use({
    'ruifm/gitlinker.nvim',      -- X
    config = function()
      require('gitlinker').setup()
    end,
  })

  use({
    'kylechui/nvim-surround', -- X
    tag = '*',
    config = function()
      require('nvim-surround').setup({})
    end,
  })

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
