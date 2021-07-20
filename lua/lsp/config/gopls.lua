local lsp = require("lsp")
local handlers_ext = require("lsp-status").extensions.clangd.setup()
local handlers = vim.tbl_extend("error", lsp.handlers, handlers_ext)
local capabilities = require("lsp.capability")

return {
  on_attach = lsp.on_attach,
  capabilities = capabilities,
  handlers = handlers,
}
