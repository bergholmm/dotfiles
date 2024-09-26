local Util = require("lazyvim.util")

return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    init = function()
      vim.g.lualine_laststatus = 0
      vim.o.laststatus = 0
    end,
    opts = function()
      local lualine_require = require("lualine_require")
      local icons = require("lazyvim.config").icons
      local auto_theme_custom = require("lualine.themes.auto")

      lualine_require.require = require
      auto_theme_custom.normal.c.bg = "none"

      return {
        options = {
          theme = {
            normal = auto_theme_custom.normal,
            insert = auto_theme_custom.normal,
            visual = auto_theme_custom.normal,
            replace = auto_theme_custom.normal,
            command = auto_theme_custom.normal,
            inactive = auto_theme_custom.normal,
          },
          globalstatus = false,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = { left = " ", right = " " },
          section_separators = { left = " ", right = " " },
        },
        sections = {},
        tabline = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            "%=",
            { "filetype", icon_only = true, padding = { left = 0, right = 0 } },
            {
              "filename",
              path = 1, -- Show relative path
              symbols = {
                modified = "",
                readonly = "",
                unnamed = "",
              },
            },
            {
              function()
                if vim.bo.modified then
                  return "●"
                else
                  return ""
                end
              end,
              color = { fg = "#63a699" },
              padding = { left = 0, right = 0 },
            },
          },
          lualine_x = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = Util.ui.fg("Statement"),
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = Util.ui.fg("Constant"),
            },
          },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
