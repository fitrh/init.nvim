local M = {}

M.with = {
  default = require("lsp.attach.with_default"),
  lsp = {
    status = require("lsp.attach.with_lsp_status"),
    signature = require("lsp.attach.with_lsp_signature"),
  },
  all = require("lsp.attach.with_all_extension"),
}

M.without = {
  formatting = require("lsp.attach.without_formatting"),
}

return M
