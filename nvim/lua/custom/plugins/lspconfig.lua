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

      -- basic example to edit lsp server's options, disabling tsserver's inbuilt formatter
      if server.name == 'tsserver' then 
        opts.on_attach = function(client, bufnr)
           client.resolved_capabilities.document_formatting = false
         end
      end
      
      server:setup(opts)
      vim.cmd [[ do User LspAttachBuffers ]]
   end)
end

return M
