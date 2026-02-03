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

-- Quit all windows when explorer is open (so :q exits Neovim)
vim.api.nvim_create_autocmd("QuitPre", {
  group = vim.api.nvim_create_augroup("quit_with_explorer", { clear = true }),
  callback = function()
    local wins = vim.api.nvim_list_wins()
    for _, win in ipairs(wins) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.bo[buf].filetype
      if ft == "snacks_picker_list" or ft == "snacks_explorer" then
        vim.cmd("qall")
        return
      end
    end
  end,
})
