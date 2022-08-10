return {
  "p00f/clangd_extensions.nvim",
  requires = { "neovim/nvim-lspconfig", module = "lspconfig" },
  config = function()
    require("config.plugin.clangd_extensions.setup")
  end,
  ft = { "c", "cpp" },
}
