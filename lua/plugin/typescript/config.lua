local server = require("lsp.config.tsserver")
if not server then
  return false
end

require("typescript").setup({
  disable_formatting = true,
  server = server,
})
