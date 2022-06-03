return {
  "ten3roberts/window-picker.nvim",
  config = function()
    require("config.plugin.window-picker.setup")
  end,
  event = "WinNew",
  module = "window-picker",
}
