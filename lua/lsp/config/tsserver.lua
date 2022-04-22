local setup = require("lsp.config")

return setup.with("typescript-language-server", {
  init_options = {
    hostInfo = "neovim",
    preferences = {
      quotePreference = "double",
      includeCompletionsWithSnippetText = true,
      generateReturnInDocTemplate = true,
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
  on_attach = function(client, bufnr)
    require("lsp.attach").with.all(client, bufnr)
  end,
})
