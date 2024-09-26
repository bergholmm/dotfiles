return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["l"] = "open",
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.o.showmode = false
            vim.o.ruler = false
            vim.o.laststatus = 0
            vim.o.showcmd = false
          end,
        },
        {
          event = "neo_tree_buffer_leave",
          handler = function()
            vim.o.showmode = false
            vim.o.ruler = false
            vim.o.laststatus = 0
            vim.o.showcmd = false
          end,
        },
      },
    },
  },
}
