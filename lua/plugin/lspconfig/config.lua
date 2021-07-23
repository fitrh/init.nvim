local lsp = require("lspconfig")

local servers = {
  clangd = require("lsp.config.clangd"), -- FIXME: properly configure clangd
  gopls = require("lsp.config.gopls"),
  pyright = require("lsp.config.pyright"),
  bashls = {},
  -- TODO: add php lsp
}

for name, conf in pairs(servers) do
  lsp[name].setup(conf)
end
