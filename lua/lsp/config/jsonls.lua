return {
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  settings = {
    json = { schemas = require("schemastore").json.schemas() },
  },
  on_attach = require("lsp.attach").with_all_extensions,
}
