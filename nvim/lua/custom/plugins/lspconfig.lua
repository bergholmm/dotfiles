local M = {}

M.setup_lsp = function(attach, capabilities)
   local lsp_installer = require "nvim-lsp-installer"

   lsp_installer.settings {
      ui = {
         icons = {
            server_installed = "﫟" ,
            server_pending = "",
            server_uninstalled = "✗",
         },
      },
   }

   lsp_installer.on_server_ready(function(server)
      local opts = {
         on_attach = attach,
         capabilities = capabilities,
         settings = {},
      }

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
      else
        if server.name == 'tsserver' then
          opts.on_attach = function(client, bufnr)
             client.resolved_capabilities.document_formatting = false
           end
        end

        server:setup(opts)
        vim.cmd [[ do User LspAttachBuffers ]]
      end
   end)
end

return M
