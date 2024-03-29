local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

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
    theme = 'nord',
    disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      { 'mode' },
    },
    lualine_b = { branch, diagnostics },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filename', 'filetype', 'encoding', 'progress' },
    lualine_z = {
      { 'location' },
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
