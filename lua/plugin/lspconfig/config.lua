local lsp = require("lspconfig")

local servers = {
  clangd = require("lsp.config.clangd"),
  gopls = require("lsp.config.gopls"),
  hls = require("lsp.config.hls"),
  pyright = require("lsp.config.pyright"),
  bashls = require("lsp.config.bashls"),
  -- TODO: add null-ls for markdown and toml(?)
}

for name, conf in pairs(servers) do
  lsp[name].setup(conf)
end
