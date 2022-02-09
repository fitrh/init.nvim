local config = {}

config.server = require("lsp.config.clangd")

require("clangd_extensions").setup(config)
