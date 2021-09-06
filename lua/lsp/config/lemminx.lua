local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")

return {
  cmd = { "lemminx", },
  capabilities = capabilities,
  handlers = handler.default(),
  on_attach = attach.with_all_extensions,
}
