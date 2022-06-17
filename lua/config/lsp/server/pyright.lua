return require("config.lsp.server").with("pyright-langserver", {
  settings = {
    python = {
      analysis = {
        stubPath = os.getenv("PYTHON_TYPE_STUBS") or "",
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
      venvPath = ".",
    },
  },
})
