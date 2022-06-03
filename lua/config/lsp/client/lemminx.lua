local handler = require("config.lsp.handler")
local attach = require("config.lsp.attach")
local capabilities = require("config.lsp.capability")

return {
  cmd = { "lemminx" },
  capabilities = capabilities,
  handlers = handler.default(),
  on_attach = attach.with.all,
}
