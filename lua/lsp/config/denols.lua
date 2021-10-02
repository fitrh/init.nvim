local has = require("lspconfig.util").root_pattern

return {
  root_dir = has(
    "mod.ts",
    "mod.js",
    "deps.ts",
    "deps.js",
    "deno.json",
    "deno.jsonc"
  ),
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  init_options = {
    enable = true,
    lint = true,
  },
  on_attach = require("lsp.attach").with_all_extensions,
}
