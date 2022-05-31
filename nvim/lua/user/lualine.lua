local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

local colors = require('nord.colors')

local nord = {}

nord.normal = {
  a = { fg = colors.nord1_gui, bg = colors.nord9_gui },
  b = { fg = colors.nord5_gui, bg = colors.nord2_gui },
  c = { fg = colors.nord4_gui, bg = colors.nord0_gui },
}

nord.insert = {
  a = { fg = colors.nord1_gui, bg = colors.nord4_gui },
  b = { fg = colors.nord6_gui, bg = colors.nord2_gui },
  y = { fg = colors.nord5_gui, bg = colors.nord2_gui },
}

nord.visual = {
  a = { fg = colors.nord0_gui, bg = colors.nord7_gui },
  b = { fg = colors.nord4_gui, bg = colors.nord2_gui },
  y = { fg = colors.nord5_gui, bg = colors.nord2_gui },
}

nord.replace = {
  a = { fg = colors.nord0_gui, bg = colors.nord11_gui },
  b = { fg = colors.nord4_gui, bg = colors.nord2_gui },
  y = { fg = colors.nord5_gui, bg = colors.nord2_gui },
}

nord.command = {
  a = { fg = colors.nord0_gui, bg = colors.nord15_gui, gui = 'bold' },
  b = { fg = colors.nord4_gui, bg = colors.nord2_gui },
  y = { fg = colors.nord5_gui, bg = colors.nord2_gui },
}

nord.inactive = {
  a = { fg = colors.nord4_gui, bg = colors.nord0_gui, gui = 'bold' },
  b = { fg = colors.nord4_gui, bg = colors.nord0_gui },
  c = { fg = colors.nord4_gui, bg = colors.nord0_gui },
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = { error = ' ', warn = ' ' },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local branch = {
  'branch',
  icons_enabled = true,
  icon = '',
}

lualine.setup({
  options = {
    icons_enabled = true,
    -- theme = "dracula-nvim",
    theme = nord,
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { branch, diagnostics },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filename', 'filetype', 'encoding', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
})
