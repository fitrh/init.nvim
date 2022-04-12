local config = {}

config.on_attach = function(client, buffer)
  require("lsp.attach").with.all(client, buffer)
  -- stylua: ignore start
  client.server_capabilities.completionProvider.triggerCharacters = {
    ".", '"', "'", "`", "/", "@", "*", "#",
    "$", "+", "^", "(", "[", "-", ":",
  }
  -- stylua: ignore end
end

config.settings = {}
config.settings.svelte = {
  plugin = {
    svelte = {
      useNewTransformation = true,
      format = { config = { svelteStrictMode = true } },
    },
  },
}

local setup = require("lsp.config")
local bin = "svelteserver"
return setup.with(bin, config)
