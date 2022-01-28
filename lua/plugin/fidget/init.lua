return {
  "j-hui/fidget.nvim",
  after = "nvim-lspconfig",
  requires = { { "neovim/nvim-lspconfig", module = "lspconfig" } },
  config = function()
    require("plugin.fidget.config")
  end,
  module = "fidget",
}
