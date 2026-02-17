return {
  {
    "bergholmm/cursor-dark.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("cursor-dark")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cursor-dark",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          local Flash = require("flash")

          ---@param opts Flash.Format
          local function format(opts)
            -- always show first and second label
            return {
              { opts.match.label1, "FlashMatch" },
              { opts.match.label2, "FlashLabel" },
            }
          end

          Flash.jump({
            search = { mode = "search" },
            label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
            pattern = [[\<]],
            action = function(match, state)
              state:hide()
              Flash.jump({
                search = { max_length = 0 },
                highlight = { matches = false },
                label = { format = format },
                matcher = function(win)
                  -- limit matches to the current label
                  return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                  end, state.results)
                end,
                labeler = function(matches)
                  for _, m in ipairs(matches) do
                    m.label = m.label2 -- use the second label
                  end
                end,
              })
            end,
            labeler = function(matches, state)
              local labels = state:labels()
              for m, match in ipairs(matches) do
                match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                match.label2 = labels[(m - 1) % #labels + 1]
                match.label = match.label1
              end
            end,
          })
        end,
        desc = "2cJump",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      on_attach = function()
        require("scrollbar.handlers.gitsigns").setup()
      end,
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = { "node_modules", ".git", "dist", "build", ".next", "__pycache__" },
          },
          grep = {
            hidden = true,
            ignored = true,
            exclude = { "node_modules", ".git", "dist", "build", ".next", "__pycache__" },
          },
          explorer = {
            hidden = true,
            ignored = true,
            exclude = { ".git", ".DS_Store" },
          },
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    enabled = true,
  },
  -- { "copilotlsp-nvim/copilot-lsp" },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   enable = false,
  --   requires = {
  --     "copilotlsp-nvim/copilot-lsp",
  --     init = function()
  --       vim.g.copilot_nes_debounce = 250
  --     end,
  --   },
  --   config = function()
  --     require("copilot").setup({
  --       nes = {
  --         enabled = true,
  --         keymap = {
  --           accept_and_goto = "<leader>q",
  --           accept = false,
  --           dismiss = "<Esc>",
  --         },
  --       },
  --     })
  --   end,
  -- },
}
