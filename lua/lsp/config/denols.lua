local has = require("lspconfig.util").root_pattern

return {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = has("mod.ts", "deps.ts", "deno.json", "deno.jsonc"),
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  init_options = {
    enable = true,
    lint = true,
  },
  on_attach = require("lsp.attach").with_all_extensions,
}
