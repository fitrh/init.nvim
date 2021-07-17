local lsp = require("lsp")
local handlers_ext = require("lsp-status").extensions.clangd.setup()
local handlers = vim.tbl_extend("error", lsp.handlers, handlers_ext)

local M = {
  cmd = {
    -- see clangd --help-hidden
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--header-insertion=iwyu",
  },
  on_attach = lsp.on_attach,
  -- TODO: figure out what is this
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  capabilities = require("lsp.capability"),
  handlers = handlers,
}

return M
