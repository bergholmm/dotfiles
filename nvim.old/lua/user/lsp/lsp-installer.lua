local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  return
end

local lspconfig = require('lspconfig')
local servers = {
  'rust_analyzer',
  'bashls',
  'cssls',
  'gopls',
  'html',
  'jsonnet_ls',
  'lemminx',
  'prosemd_lsp',
  'sumneko_lua',
  'tailwindcss',
  'tsserver',
  'yamlls',
  -- 'denols',
}

lsp_installer.setup({
  ensure_installed = servers,
})

for _, server in pairs(servers) do
  local opts = {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
  }

  if server == 'sumneko_lua' then
    local sumneko_opts = require('user.lsp.settings.sumneko_lua')
    opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
  end

  if server == 'rust_analyzer' then
    require("rust-tools").setup({
      server = opts,
    })
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
