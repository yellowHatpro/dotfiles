dofile(vim.g.base46_cache .. "lsp")

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

require("lspconfig").lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

require("lspconfig").clangd.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  root_pattern = {
    '.clangd',
    '.git'
  },
  single_file_support = true
}

require 'lspconfig'.pylsp.setup {}

require("lspconfig").tsserver.setup {}

require("lspconfig").tailwindcss.setup {}

require("lspconfig").html.setup {}

require("lspconfig").cadence.setup {
  cmd = { "flow", "cadence", "language-server" },
  filetypes = { "cdc" },
}

require("lspconfig").solidity_ls.setup {}

require("lspconfig").jdtls.setup {}

require("lspconfig").gopls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      }
    }
  }
}

return M
