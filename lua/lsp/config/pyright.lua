local setup = require("lsp.config")

return setup.with("pyright-langserver", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
      },
      venvPath = ".",
    },
  },
})
