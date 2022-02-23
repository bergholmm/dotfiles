local null_ls_status_ok, null_ls = pcall(require, "null-ls")

if not null_ls_status_ok then
  return
end

local b = null_ls.builtins

local sources = {
  -- JS
  b.formatting.prettier,
  b.diagnostics.eslint,

  -- GO
  b.formatting.gofumpt,

  -- Spelling
  b.completion.spell,
  b.diagnostics.write_good,

  -- Lua
  b.formatting.stylua,
  b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}

M.setup = function()
  null_ls.setup {
     debug = false,
     sources = sources,

     -- format on save
     on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
           vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()"
        end
     end,
  }
end

return M
