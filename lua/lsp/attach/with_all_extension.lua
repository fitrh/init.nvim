local default = require("lsp.attach.with_default")
local lsp_signature = require("lsp.attach.with_lsp_signature")
local lsp_status = require("lsp.attach.with_lsp_status")

return function(client, bufnr)
  default(client, bufnr)
  lsp_signature()
  lsp_status(client)
end
