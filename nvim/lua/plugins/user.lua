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
    "ThePrimeagen/harpoon",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0),
      },
    },
    keys = function()
      -- stylua: ignore
      local keys = {
        { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon File" },
        { "<leader>q", function() require("harpoon"):list():remove() end, desc = "Harpoon Remove" },
        { "<leader><Tab>", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon Quick Menu" },
        { "<S-Tab>", function() require("harpoon"):list():prev() end, desc = "Previous Harpoon file" },
        { "<Tab>", function() require("harpoon"):list():next() end, desc = "Next Harpoon file" },
      }
      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
}
