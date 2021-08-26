local lsp = require("lspconfig")

local servers = {
  bashls = require("lsp.config"),
  clangd = require("lsp.config.clangd"),
  cssls = require("lsp.config"),
  gopls = require("lsp.config.gopls"),
  hls = require("lsp.config.hls"),
  html = require("lsp.config"),
  pyright = require("lsp.config.pyright"),
  sumneko_lua = require("lsp.config.sumneko_lua"),
  -- TODO: add null-ls for markdown and toml(?)
}

for name, conf in pairs(servers) do
  lsp[name].setup(conf)
end
