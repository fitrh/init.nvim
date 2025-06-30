-- TODO: Remove, use pyrightconfig.json, SEE: https://microsoft.github.io/pyright/#/configuration
return require("config.lsp.server").with("pyright-langserver", {
  root_dir = require("lspconfig.util").root_pattern("*.py"),
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
