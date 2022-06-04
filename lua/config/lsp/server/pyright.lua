return require("config.lsp.server").with("pyright-langserver", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
      },
      venvPath = ".",
    },
  },
})
