local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")

return {
  cmd = { "gopls", "serve", },
  on_attach = attach.with_all_extensions,
  capabilities = capabilities,
  handlers = handler.default(),
  settings = {
    gopls = {
      gofumpt = true, -- A stricter gofmt
      usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
      analyses = {
        fieldalignment = true, -- find structs that would use less memory if their fields were sorted
        nilness = true, -- check for redundant or impossible nil comparisons
        shadow = true, -- check for possible unintended shadowing of variables
        unusedparams = true, -- check for unused parameters of functions
        unusedwrite = true, -- checks for unused writes, an instances of writes to struct fields and arrays that are never read
      },
    },
  },
}
