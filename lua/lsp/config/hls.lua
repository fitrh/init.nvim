local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")

return {
  capabilities = capabilities,
  handlers = handler.default(),
  settings = {
    haskell = {
      formattingProvider = "brittanty",
      maxCompletions = 10,
    },
  },
  on_attach = attach.with_all_extensions,
}
