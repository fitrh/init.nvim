local default = require("lsp.attach.with_default")

return function(client, bufnr)
  default(client, bufnr)

  if client.supports_method("textDocument/signatureHelp") then
    require("lsp.attach.with_lsp_signature")
  end
end
