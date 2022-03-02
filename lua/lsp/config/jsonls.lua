local setup = require("lsp.config")
local config = {}
local ok, schemastore = pcall(require, "schemastore")

if ok then
  config.settings = {
    json = {
      schemas = schemastore.json.schemas(),
    },
  }
end

return setup.with("vscode-json-language-server", config)
