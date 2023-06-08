return {
  "mvllow/modes.nvim",
  config = function()
    require("config.plugin.modes.setup")
  end,
  keys = { "d", "y" },
  event = "ModeChanged",
}
