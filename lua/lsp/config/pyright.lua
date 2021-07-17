local lsp = require("lsp")

local M = {
  on_attach = lsp.on_attach,
  capabilities = require("lsp.capability"),
  handlers = lsp.handlers,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
      },
      venvPath = ".",
    }
  },
}

return M
