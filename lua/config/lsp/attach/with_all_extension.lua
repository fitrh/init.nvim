return function(client, bufnr)
  require("config.lsp.attach.with_default")(client, bufnr)

  if client.server_capabilities.signatureHelpProvider then
    require("config.lsp.attach.with_lsp_signature")()
  end

  if client.server_capabilities.documentSymbolProvider then
    require("config.lsp.attach.with_navic")(client, bufnr)
  end
end
