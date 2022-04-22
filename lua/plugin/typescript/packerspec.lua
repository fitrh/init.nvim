return {
  "jose-elias-alvarez/typescript.nvim",
  requires = {
    { "neovim/nvim-lspconfig", module = "lspconfig" },
  },
  config = function()
    require("plugin.typescript.config")
  end,
  ft = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
}
