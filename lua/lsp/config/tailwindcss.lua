local setup = require("lsp.config")
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

return setup.with("tailwindcss-language-server", config)
