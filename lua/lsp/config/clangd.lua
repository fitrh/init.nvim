local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")
local clangd_ext_handler = require("lsp-status").extensions.clangd.setup()

return {
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
  capabilities = capabilities,
  handlers = handler.with({ handler.hover, clangd_ext_handler }),
  -- TODO: figure out what is this
  init_options = {
    clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  on_attach = attach.with_all_extensions,
}
