local M = {}

M.with = {
  default = require("lsp.attach.with_default"),
  lsp = {
    signature = require("lsp.attach.with_lsp_signature"),
  },
  all = require("lsp.attach.with_all_extension"),
}

return M
