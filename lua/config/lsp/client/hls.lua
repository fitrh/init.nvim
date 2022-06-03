return require("config.lsp.client").with("haskell-language-server-wrapper", {
  settings = {
    haskell = {
      formattingProvider = "brittany",
      maxCompletions = 10,
    },
  },
})
