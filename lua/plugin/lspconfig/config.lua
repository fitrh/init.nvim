local lsp = require("lspconfig")
local setup = require("lsp.config")

local servers = {
  bashls = setup.with("bash-language-server"),
  cssls = setup.with("vscode-css-language-server"),
  denols = require("lsp.config.denols"),
  emmet_ls = require("lsp.config.emmet_ls"),
  gopls = require("lsp.config.gopls"),
  gradle_ls = setup.with("gradle-language-server"),
  hls = require("lsp.config.hls"),
  html = setup.with("vscode-html-language-server"),
  intelephense = setup.with("intelephense"),
  jsonls = require("lsp.config.jsonls"),
  kotlin_language_server = setup.with("kotlin-language-server"),
  lemminx = setup.with("lemminx"),
  omnisharp = require("lsp.config.omnisharp"),
  phpactor = setup.with("phpactor"),
  pyright = require("lsp.config.pyright"),
  sumneko_lua = require("lsp.config.sumneko_lua"),
  svelte = require("lsp.config.svelte"),
  tailwindcss = require("lsp.config.tailwindcss"),
  taplo = setup.with("taplo"),
  texlab = require("lsp.config.texlab"),
  yamlls = setup.with("yaml-language-server"),
  vls = setup.with("vls", { cmd = { "vls" } }),
  zls = setup.with("zls"),
}

for server, config in pairs(servers) do
  if config then
    lsp[server].setup(config)
  end
end
