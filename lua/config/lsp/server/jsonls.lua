local config = {}
local ok, schemastore = pcall(require, "schemastore")

if ok then
  config.settings = {
    json = {
      schemas = schemastore.json.schemas(),
    },
  }
end

return require("config.lsp.server").with("vscode-json-language-server", config)
