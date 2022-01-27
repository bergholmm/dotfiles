require("plugins.configs.others").lsp_handlers()

local function on_attach(_, bufnr)
   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

   -- Enable completion triggered by <c-x><c-o>
   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
   require("core.mappings").lspconfig()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lsp_installer = require "nvim-lsp-installer"

lsp_installer.settings {
   ui = {
      icons = {
         server_installed = "﫟",
         server_pending = "",
         server_uninstalled = "✗",
      },
   },
}

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {},
  }

  if server.name == "rust_analyzer" then
    -- opts.settings = {
    --   ["rust-analyzer"] = {
    --     checkOnSave = {
    --       allFeatures = true,
    --       overrideCommand = {
    --         "cargo",
    --         "clippy",
    --         "--all-target",
    --         "--all-features",
    --         -- "-- -D warnings"
    --       }
    --     },
    --   },
    -- }
    --
    opts.on_attach = function(client, bufnr)
      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end

      -- Run nvchad's attach
      on_attach(client, bufnr)

      -- Use nvim-code-action-menu for code actions for rust
      -- buf_set_keymap("n", "<leader>ca", "lua vim.lsp.buf.range_code_action()<CR>", { noremap = true, silent = true })

      -- autoformat on save
      -- if client.resolved_capabilities.document_formatting then
      --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
      -- end
    end

    require("rust-tools").setup({
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
    })
  else
    server:setup(opts)
  end

  vim.cmd [[ do User LspAttachBuffers ]]
end)

