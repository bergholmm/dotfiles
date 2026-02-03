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
    lazy = false,
    keys = {
      { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Obsidian Today" },
      { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Obsidian Yesterday" },
      { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Obsidian Search" },
      { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian Quick Switch" },
      { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian Backlinks" },
      { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Obsidian New" },
      { "<leader>ol", "<cmd>Obsidian follow_link<cr>", desc = "Obsidian Follow Link" },
      { "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Obsidian Toggle Checkbox" },
    },
    opts = {
      legacy_commands = false,
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
