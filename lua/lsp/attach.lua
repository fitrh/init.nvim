local Attach = {}

Attach.with = {
  default = require("lsp.attach.with_default"),
  extension = {
    signature = require("lsp.attach.with_lsp_signature"),
  },
  all = require("lsp.attach.with_all_extension"),
}

return Attach
