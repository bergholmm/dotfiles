if vim.g.vscode then
  vim.cmd [[source $HOME/.config/nvim/vscode/settings.vim]]
  vim.cmd [[source $HOME/.config/nvim/vscode/easymotion.vim]]
  return
else
  require('user.plugins')
  require('user.cmp')
  require('user.lsp')
  require('user.telescope')
  require('user.treesitter')
  require('user.autopairs')
  require('user.comment')
  require('user.gitsigns')
  require('user.nvim-tree')
  require('user.bufferline')
  require('user.lualine')
  require('user.toggleterm')
  require('user.project')
  require('user.impatient')
  require('user.indentline')
  require('user.alpha')
  require('user.whichkey')
  require('user.autocommands')
end
