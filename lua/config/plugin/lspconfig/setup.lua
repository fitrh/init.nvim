local lsp = require("lspconfig")
local server_config = require("config.lsp.server")

local servers = {
  bashls = server_config.with("bash-language-server"),
  cssls = server_config.with("vscode-css-language-server"),
  denols = require("config.lsp.server.denols"),
  emmet_ls = require("config.lsp.server.emmet_ls"),
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
  sumneko_lua = require("config.lsp.server.sumneko_lua"),
  svelte = require("config.lsp.server.svelte"),
  tailwindcss = require("config.lsp.server.tailwindcss"),
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
