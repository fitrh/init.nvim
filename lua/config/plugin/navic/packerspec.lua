return {
  "SmiteshP/nvim-navic",
  requires = { "neovim/nvim-lspconfig", module = "lspconfig" },
  config = function()
    require("config.plugin.navic.setup")
  end,
  module = "nvim-navic",
}
