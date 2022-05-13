return function(client, bufnr)
  require("lsp.attach.with_default")(client, bufnr)

  if client.supports_method("textDocument/signatureHelp") then
    require("lsp.attach.with_lsp_signature")
  end
end
