local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")

return {
  on_attach = attach.with_all_extensions,
  capabilities = capabilities,
  handlers = handler.default(),
}
