local Attach = {}

Attach.with = {
  default = require("config.lsp.attach.with_default"),
  extension = {
    signature = require("config.lsp.attach.with_lsp_signature"),
    navic = require("config.lsp.attach.with_navic"),
  },
  all = require("config.lsp.attach.with_all_extension"),
}

return Attach
