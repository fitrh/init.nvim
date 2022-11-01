require("phpactor").setup({
  install = {
    bin = "phpactor",
  },
  lspconfig = require("config.lsp.server").with("phpactor"),
})
