return {
  "phaazon/hop.nvim",
  config = function()
    require("plugin.hop.config")
    require("plugin.hop.keymap")
  end,
  keys = { "f", "F" },
}
