return {
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  settings = {
    texlab = {
      build = {
        executable = "tectonic",
        args = {
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
          "--outdir dist",
        },
      },
      diagnosticsDelay = 250,
    },
  },
  on_attach = require("lsp.attach").with.all,
}
