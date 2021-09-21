return {
  root_dir = require("lspconfig.util").root_pattern(
    ".stylelintrc",
    ".stylelintrc.json",
    ".stylelintrc.yml",
    ".stylelintrc.js",
    "stylelint.config.js",
    "stylelint.config.cjs"
  ),
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  settings = {
    stylelintplus = {
      autoFixOnFormat = true,
      cssInJs = true,
      validateOnSave = true,
    },
  },
  on_attach = require("lsp.attach").with_all_extensions,
}
