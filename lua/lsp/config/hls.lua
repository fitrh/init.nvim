local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")

return {
  capabilities = capabilities,
  handlers = handler.default(),
  settings = {
    haskell = {
      formattingProvider = "brittany",
      maxCompletions = 10,
    },
  },
  on_attach = attach.with.all,
}
