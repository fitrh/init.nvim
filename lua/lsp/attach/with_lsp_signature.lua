local signature = {
  plugin = require("lsp_signature"),
  config = require("plugin.lspsignature.config"),
}

return function()
  signature.plugin.on_attach(signature.config)
end
