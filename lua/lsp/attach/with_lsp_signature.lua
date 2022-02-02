local ok, plugin = pcall(require, "lsp_signature")

return function()
  if ok then
    plugin.on_attach(require("plugin.lspsignature.config"))
  end
end
