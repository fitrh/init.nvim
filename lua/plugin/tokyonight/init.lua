return {
  "folke/tokyonight.nvim",
  config = function()
    require("plugin.tokyonight.config")
  end,
  event = "VimEnter",
  module = "tokyonight",
}
