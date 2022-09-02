local ok, util = pcall(require, "lspconfig.util")
local config = {}

if ok then
  config.root_dir = util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.ts"
  )
end

config.on_attach = function(client, bufnr)
  require("config.lsp.attach").with.all(client, bufnr)
end

return require("config.lsp.server").with("tailwindcss-language-server", config)
