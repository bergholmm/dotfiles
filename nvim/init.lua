-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.vscode then
  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == "i" then
        require("vscode").action("neovim-ui-indicator.insert")
      elseif mode == "v" then
        require("vscode").action("neovim-ui-indicator.visual")
      elseif mode == "n" then
        require("vscode").action("neovim-ui-indicator.normal")
      end
    end,
  })

  local keymap = vim.keymap.set

  keymap("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
  keymap("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")

  -- general keymaps
  keymap({ "n", "v" }, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
  keymap(
    { "n", "v" },
    "<leader>e",
    "<cmd>lua require('vscode').action('workbench.files.action.focusFilesExplorer')<CR>"
  )
  keymap({ "n", "v" }, "<leader>b", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>")
  keymap({ "n", "v" }, "<leader>z", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")

  keymap({ "n", "v" }, "<leader>x", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
  keymap({ "n", "v" }, "<C-x>", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>")
  -- keymap({ "n", "v" }, "[d", "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>")

  keymap({ "n", "v" }, "<leader>c", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
  keymap({ "n", "v" }, "<leader>,", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")

  -- keymap({ "n", "v" }, "gr", "<cmd>lua require('vscode').action('editor.action.referenceSearch.trigger')<CR>")
  keymap({ "n", "v" }, "gr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>")

  -- harpoon keymaps
  keymap({ "n", "v" }, "<leader>a", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
  keymap({ "n", "v" }, "<leader><tab>", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
  keymap({ "n", "v" }, "<leader>d", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
  keymap({ "n", "v" }, "<leader>1", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
  keymap({ "n", "v" }, "<leader>2", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
  keymap({ "n", "v" }, "<leader>3", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
  keymap({ "n", "v" }, "<leader>4", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
  keymap({ "n", "v" }, "<leader>5", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
  keymap({ "n", "v" }, "<leader>6", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
  keymap({ "n", "v" }, "<leader>7", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
  keymap({ "n", "v" }, "<leader>8", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
  keymap({ "n", "v" }, "<leader>9", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

  -- project manager keymaps
  keymap({ "n", "v" }, "<leader>pa", "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
  keymap({ "n", "v" }, "<leader>po", "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
  keymap({ "n", "v" }, "<leader>pe", "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")
end
