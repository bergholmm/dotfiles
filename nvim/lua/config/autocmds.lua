vim.cmd([[
  augroup MyColors
  autocmd!
  autocmd ColorScheme * highlight BufferLineFill guibg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineSeparator guifg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineSeparatorSelected guifg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineBackground guibg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineCloseButton guibg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineCloseButtonVisible guibg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineCloseButtonSelected guibg=#1e1e2e

  autocmd ColorScheme * highlight BufferLineSeparator guifg=#1e1e2e guibg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineSeparatorVisible guifg=#1e1e2e guibg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineSeparatorSelected guifg=#1e1e2e guibg=#1e1e2e

  autocmd ColorScheme * highlight BufferLineBackground guibg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineBufferVisible guibg=#1e1e2e


  autocmd ColorScheme * highlight BufferLineModified guibg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineModifiedVisible guibg=#1e1e2e
  autocmd ColorScheme * highlight BufferLineModifiedSelected guibg=#1e1e2e

  augroup END
]])
