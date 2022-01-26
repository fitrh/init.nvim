local default = require("lsp.attach.with_default")
local lsp_signature = require("lsp.attach.with_lsp_signature")

return function(client, bufnr)
  default(client, bufnr)
  lsp_signature()
end
