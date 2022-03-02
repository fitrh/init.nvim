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
    local attach = require("lsp.attach")
    local ok, util = pcall(require, "nvim-lsp-ts-utils")
    attach.without.formatting(client)
    attach.with.all(client, bufnr)
    if ok then
      util.setup({
        eslint_enable_diagnostics = true,
        eslint_bin = "eslint_d",
        enable_formatting = true,
        formatter = "prettierd",
      })
      util.setup_client(client)
    end
  end,
})
