return {
  root_dir = require("lspconfig.util").root_pattern(
    "tailwind.config.js",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.ts"
  ),
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  on_attach = require("lsp.attach").with.all,
}
