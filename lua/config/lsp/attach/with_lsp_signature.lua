return function()
  local ok, plugin = pcall(require, "lsp_signature")
  if ok then
    plugin.on_attach(require("config.plugin.lsp_signature.setup"))
  end
end
