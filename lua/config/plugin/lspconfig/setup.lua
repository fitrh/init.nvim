local lsp = require("lspconfig")
local client = require("config.lsp.client")

local client_configuration = {
  bashls = client.with("bash-language-server"),
  cssls = client.with("vscode-css-language-server"),
  denols = require("config.lsp.client.denols"),
  emmet_ls = require("config.lsp.client.emmet_ls"),
  gopls = require("config.lsp.client.gopls"),
  gradle_ls = client.with("gradle-language-server"),
  hls = require("config.lsp.client.hls"),
  html = client.with("vscode-html-language-server"),
  intelephense = client.with("intelephense"),
  jsonls = require("config.lsp.client.jsonls"),
  kotlin_language_server = client.with("kotlin-language-server"),
  lemminx = client.with("lemminx"),
  omnisharp = require("config.lsp.client.omnisharp"),
  phpactor = client.with("phpactor"),
  pyright = require("config.lsp.client.pyright"),
  sumneko_lua = require("config.lsp.client.sumneko_lua"),
  svelte = require("config.lsp.client.svelte"),
  tailwindcss = require("config.lsp.client.tailwindcss"),
  taplo = client.with("taplo"),
  texlab = require("config.lsp.client.texlab"),
  yamlls = client.with("yaml-language-server"),
  vls = client.with("vls", { cmd = { "vls" } }),
  zls = client.with("zls"),
}

for server_name, config in pairs(client_configuration) do
  if config then
    lsp[server_name].setup(config)
  end
end
