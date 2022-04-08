local config = {}

config.server = require("lsp.config.clangd")

if not config.server then
  return false
end

require("clangd_extensions").setup(config)
