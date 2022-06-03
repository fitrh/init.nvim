local config = {}

config.server = require("config.lsp.client.clangd")

if not config.server then
  return false
end

require("clangd_extensions").setup(config)
