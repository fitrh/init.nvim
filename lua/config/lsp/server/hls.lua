return require("config.lsp.server").with("haskell-language-server-wrapper", {
  settings = {
    haskell = {
      formattingProvider = "brittany",
      maxCompletions = 10,
    },
  },
})
