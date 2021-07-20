local lsp = require("lsp")
local capabilities = require("lsp.capability")

return {
  on_attach = lsp.on_attach,
  capabilities = capabilities,
  handlers = lsp.handlers,
}
