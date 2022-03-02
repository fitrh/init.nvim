local setup = require("lsp.config")
local ok, util = pcall(require, "lspconfig.util")
local config = {}

if ok then
  config.root_dir = util.root_pattern(
    "mod.ts",
    "mod.js",
    "deps.ts",
    "deps.js",
    "deno.json",
    "deno.jsonc"
  )
end

config.init_options = {
  enable = true,
  lint = true,
}

return setup.with("deno", config)
