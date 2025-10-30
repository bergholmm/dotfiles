return {
  { "mg979/vim-visual-multi" },
  { "christoomey/vim-sort-motion" },
  { "sindrets/diffview.nvim" },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "ThePrimeagen/harpoon",
    keys = function()
      -- stylua: ignore
      local keys = {
        { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon File" },
        { "<leader>q", function() require("harpoon"):list():remove() end, desc = "Harpoon Remove" },
        { "<leader><Tab>", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon Quick Menu" },
        { "<S-Tab>", function() require("harpoon"):list():prev() end, desc = "Previous Harpoon file" },
        { "<Tab>", function() require("harpoon"):list():next() end, desc = "Next Harpoon file" },
      }

      for i = 1, 9 do
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
  {
    "BourbonBidet/Barpoon",
    dependencies = {
      { "ThePrimeagen/harpoon", branch = "harpoon2" },
      { "akinsho/bufferline.nvim" },
    },
    opts = {
      pin_icon = false,
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        close_command = false,
        right_mouse_command = false,
        close_icon = "󰐃",
        diagnostics = false,
      },
    },
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    opts = {
      workspaces = {
        {
          name = "Obisdian",
          path = "~/Obisidian",
        },
      },
      daily_notes = {
        folder = "Journals",
        date_format = "%Y/%b/%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        template = "Daily template.md",
      },
      templates = {
        folder = "Obsidian Extras/Templates",
        -- date_format = "%Y-%m-%d",
        -- time_format = "%H:%M",
      },
    },
  },
}
