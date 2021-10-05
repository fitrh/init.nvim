local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")

return {
  capabilities = capabilities,
  handlers = handler.default(),
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
      },
      venvPath = ".",
    },
  },
  on_attach = attach.with_all_extensions,
}
