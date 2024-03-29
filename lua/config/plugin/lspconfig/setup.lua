local lsp = require("lspconfig")
local root_pattern = require("lspconfig.util").root_pattern
local server_config = require("config.lsp.server")

local servers = {
  astro = server_config.with("astro-ls", {
    root_dir = root_pattern("astro.config.mjs"),
  }),
  bashls = server_config.with("bash-language-server"),
  clangd = require("config.lsp.server.clangd"),
  cssls = server_config.with("vscode-css-language-server"),
  denols = require("config.lsp.server.denols").config({
    root_dir = root_pattern(
      "mod.ts",
      "mod.js",
      "deps.ts",
      "deps.js",
      "deno.json",
      "deno.jsonc"
    ),
  }),
  emmet_ls = require("config.lsp.server.emmet_ls"),
  fennel_ls = server_config.with("fennel-ls"),
  gopls = require("config.lsp.server.gopls"),
  gradle_ls = server_config.with("gradle-language-server"),
  hls = require("config.lsp.server.hls"),
  html = server_config.with("vscode-html-language-server"),
  intelephense = server_config.with("intelephense"),
  jsonls = require("config.lsp.server.jsonls"),
  kotlin_language_server = server_config.with("kotlin-language-server"),
  lemminx = server_config.with("lemminx"),
  marksman = server_config.with("marksman"),
  omnisharp = require("config.lsp.server.omnisharp"),
  pyright = require("config.lsp.server.pyright"),
  lua_ls = require("config.lsp.server.lua_ls"),
  svelte = require("config.lsp.server.svelte"),
  tailwindcss = server_config.with("tailwindcss-language-server", {
    root_dir = root_pattern(
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.ts"
    ),
  }),
  taplo = server_config.with("taplo"),
  texlab = require("config.lsp.server.texlab"),
  yamlls = server_config.with("yaml-language-server"),
  vls = server_config.with("vls", { cmd = { "vls" } }),
  volar = server_config.with("vue-language-server"),
  zls = server_config.with("zls"),
}

for server, config in pairs(servers) do
  if config then
    lsp[server].setup(config)
  end
end
