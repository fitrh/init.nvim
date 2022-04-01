return {
  "folke/tokyonight.nvim",
  config = function()
    require("plugin.themes.tokyonight.config")
  end,
  event = "VimEnter",
  module = "tokyonight",
}
