return {
  "p00f/clangd_extensions.nvim",
  requires = { "neovim/nvim-lspconfig", module = "lspconfig" },
  config = function()
    require("config.plugin.clangdext.setup")
  end,
  ft = { "c", "cpp" },
  module = "clangd_extensions",
}
