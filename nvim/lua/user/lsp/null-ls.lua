local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier,
    formatting.black.with({ extra_args = { '--fast' } }),
    formatting.stylua,
    formatting.gofumpt,
    diagnostics.eslint_d,
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- vim.lsp.buf.format({ bufnr = bufnr })
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
