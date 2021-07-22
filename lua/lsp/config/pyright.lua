local handler = require("lsp.handler")
local attach = require("lsp.attach")

local M = {
  on_attach = attach.with_all_extensions,
  capabilities = require("lsp.capability"),
  handlers = handler.default(),
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
