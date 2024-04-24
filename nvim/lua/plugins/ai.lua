local gpconfig = require("../config/gp")

return {
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup(gpconfig)
    end,
  },
  {
    "Exafunction/codeium.vim",
    -- cmd = "Codeium",
    -- build = ":Codeium Auth",
    config = function()
      vim.keymap.set("i", "<C-j>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-k>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-l>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-h>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
      vim.keymap.set("n", "<c-q>", function()
        return vim.fn["codeium#Chat"]()
      end, { expr = true, silent = true })
    end,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   event = "InsertEnter",
  --   opts = {
  --     suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<C-j>" } },
  --     panel = {
  --       enabled = true,
  --       auto_refresh = false,
  --       keymap = {
  --         jump_prev = "[[",
  --         jump_next = "]]",
  --         accept = "<CR>",
  --         refresh = "gr",
  --         open = "<M-CR>",
  --       },
  --       layout = {
  --         position = "bottom", -- | top | left | right
  --         ratio = 0.4,
  --       },
  --     },
  --     filetypes = {
  --       markdown = true,
  --       help = true,
  --     },
  --   },
  -- },
}
