return function()
  local ok, plugin = pcall(require, "lsp_signature")
  if ok then
    plugin.on_attach(require("config.plugin.lspsignature.setup"))
  end
end
