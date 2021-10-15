return {
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  on_attach = require("lsp.attach").with_all_extensions,
}
