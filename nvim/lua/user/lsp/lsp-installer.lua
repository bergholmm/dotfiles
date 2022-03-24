local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

  if server.name == "jsonls" then
   local jsonls_opts = require("user.lsp.settings.jsonls")
   opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == "sumneko_lua" then
   local sumneko_opts = require("user.lsp.settings.sumneko_lua")
   opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "rust_analyzer" then
    -- Initialize the LSP via rust-tools instead
    require("rust-tools").setup {
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
    }
    server:attach_buffers()
    -- Only if standalone support is needed
    require("rust-tools").start_standalone_if_required()
    require('rust-tools.inlay_hints').set_inlay_hints()
    require('rust-tools.runnables').runnables()
    return
  end

  server:setup(opts)
end)
