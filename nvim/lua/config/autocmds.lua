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
