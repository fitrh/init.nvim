local lsp = require("lspconfig")
local default = require("lsp.config")

local servers = {
  bashls = default,
  clangd = require("lsp.config.clangd"),
  cssls = default,
  dartls = require("lsp.config.dartls"),
  denols = require("lsp.config.denols"),
  gopls = require("lsp.config.gopls"),
  hls = require("lsp.config.hls"),
  html = default,
  intelephense = default,
  jsonls = default,
  kotlin_language_server = default,
  lemminx = require("lsp.config.lemminx"),
  phpactor = default,
  pyright = require("lsp.config.pyright"),
  stylelint_lsp = require("lsp.config.stylelint"),
  sumneko_lua = require("lsp.config.sumneko_lua"),
  tailwindcss = require("lsp.config.tailwindcss"),
  yamlls = default,
}

for name, conf in pairs(servers) do
  lsp[name].setup(conf)
end
