return require("config.lsp.client").with("pyright-langserver", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
      },
      venvPath = ".",
    },
  },
})
