local handler = require("lsp.handler")
local attach = require("lsp.attach")
local clangd_ext_handler = require("lsp-status").extensions.clangd.setup()

local M = {
  cmd = {
    -- see clangd --help-hidden
    "clangd",
    "--background-index",
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    "--clang-tidy",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--header-insertion=iwyu",
  },
  on_attach = attach.with_all_extensions,
  -- TODO: figure out what is this
  init_options = {
    clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  capabilities = require("lsp.capability"),
  handlers = handler.with({
    handler.on_publish_diagnostics,
    handler.hover,
    clangd_ext_handler,
  }),
}

return M
