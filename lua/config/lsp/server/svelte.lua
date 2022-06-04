local config = {}

config.on_attach = function(client, buffer)
  require("config.lsp.attach").with.all(client, buffer)
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

return require("config.lsp.server").with("svelteserver", config)
