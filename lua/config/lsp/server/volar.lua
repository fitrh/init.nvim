local config = {}
local bin = "vue-language-server"
return require("config.lsp.server").with(bin, config)
