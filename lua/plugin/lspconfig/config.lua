local lsp = require("lspconfig")
local default = require("lsp.config")

local servers = {
  bashls = default,
  clangd = require("lsp.config.clangd"),
  cssls = default,
  dartls = require("lsp.config.dartls"),
  denols = require("lsp.config.denols"),
  emmet_ls = require("lsp.config.emmet_ls"), -- FIX: Integration with auto pairs plugin
  gopls = require("lsp.config.gopls"),
  hls = require("lsp.config.hls"),
  html = default,
  intelephense = default,
  jsonls = require("lsp.config.jsonls"),
  kotlin_language_server = default,
  lemminx = require("lsp.config.lemminx"),
  omnisharp = require("lsp.config.omnisharp"),
  phpactor = default,
  pyright = require("lsp.config.pyright"),
  stylelint_lsp = require("lsp.config.stylelint"),
  sumneko_lua = require("lsp.config.sumneko_lua"),
  tailwindcss = require("lsp.config.tailwindcss"),
  taplo = default,
  texlab = require("lsp.config.texlab"),
  tsserver = require("lsp.config.tsserver"),
  yamlls = default,
  zls = default,
}

for server, config in pairs(servers) do
  lsp[server].setup(config)
end
