local client = require("config.lsp.server.tsserver")
if not client then
  return false
end

require("typescript").setup({
  disable_formatting = true,
  server = client,
})
