local client = require("config.lsp.server.tsserver")
if not client then
  return false
end

client.root_dir = require("lspconfig.util").root_pattern(
  "package.json",
  "tsconfig.json",
  "jsconfig.json"
)

require("typescript").setup({
  disable_formatting = true,
  server = client,
})
