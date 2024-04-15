return {
  { "mg979/vim-visual-multi" },
  { "christoomey/vim-sort-motion" },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    keys = { { "s", "<cmd>HopWord<cr>", desc = "Hop to word" } },
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
      vim.api.nvim_set_keymap("n", "s", ":HopWord<cr>", { silent = true })
    end,
  },
}
