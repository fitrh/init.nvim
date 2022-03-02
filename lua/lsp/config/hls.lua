local setup = require("lsp.config")

return setup.with("haskell-language-server-wrapper", {
  settings = {
    haskell = {
      formattingProvider = "brittany",
      maxCompletions = 10,
    },
  },
})
