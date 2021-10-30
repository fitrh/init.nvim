local M = {
  "neovim/nvim-lspconfig",
  config = function()
    require("plugin.lspconfig.config")
  end,
  ft = {
    "c",
    "cpp",
    "css",
    "dart",
    "go",
    "gomod",
    "haskell",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "kotlin",
    "lua",
    "php",
    "python",
    "scss",
    "sh",
    "svg",
    "typescript",
    "typescriptreact",
    "vue",
    "xml",
    "xsd",
    "yaml",
    "zig",
    "zir",
  },
  module = "lspconfig",
}

return M
