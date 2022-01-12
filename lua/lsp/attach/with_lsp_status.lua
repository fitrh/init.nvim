local plugin = require("lsp-status")
local config = require("plugin.lspstatus.config")

return function(client)
  plugin.register_progress()
  plugin.on_attach(client)
  plugin.config(config)
end
