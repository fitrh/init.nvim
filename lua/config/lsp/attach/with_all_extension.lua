return function(client, bufnr)
  require("config.lsp.attach.with_default")(client, bufnr)

  if client.supports_method("textDocument/signatureHelp") then
    require("config.lsp.attach.with_lsp_signature")()
  end

  if client.supports_method("textDocument/documentSymbol") then
    require("config.lsp.attach.with_navic")(client, bufnr)
  end
end
