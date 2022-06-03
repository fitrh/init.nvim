local bin = "clangd"
local config = {}

config.cmd = {
  bin, -- SEE: clangd --help-hidden for possible options
  -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
  -- to add more `checks`, create  a `.clang-tidy` file in the root directory
  -- SEE: https://clang.llvm.org/extra/clang-tidy
  "--clang-tidy",
  "--completion-style=bundled",
  "--cross-file-rename",
  "--header-insertion=iwyu",
}

config.init_options = {
  clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
  -- TODO: figure out what is this
  usePlaceholders = true,
  completeUnimported = true,
  semanticHighlighting = true,
}

return require("config.lsp.client").with(bin, config)
