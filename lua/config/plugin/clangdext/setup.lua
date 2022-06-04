local config = {}

config.server = require("config.lsp.server.clangd")

if not config.server then
  return false
end

require("clangd_extensions").setup(config)
