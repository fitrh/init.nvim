local lspconfig = require("config.lsp.server").with("phpactor")
if not lspconfig then
  return
end

require("phpactor").setup({
  install = {
    bin = "phpactor",
  },
  lspconfig = lspconfig,
})
