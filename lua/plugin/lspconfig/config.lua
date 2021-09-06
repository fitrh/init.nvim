local lsp = require("lspconfig")
local default = require("lsp.config")

local servers = {
  bashls = default,
  clangd = require("lsp.config.clangd"),
  cssls = default,
  gopls = require("lsp.config.gopls"),
  hls = require("lsp.config.hls"),
  html = default,
  lemminx = require("lsp.config.lemminx"),
  pyright = require("lsp.config.pyright"),
  sumneko_lua = require("lsp.config.sumneko_lua"),
  -- TODO: add null-ls for markdown and toml(?)
}

for name, conf in pairs(servers) do
  lsp[name].setup(conf)
end
