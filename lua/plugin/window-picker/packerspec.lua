return {
  "ten3roberts/window-picker.nvim",
  config = function()
    require("plugin.window-picker.config")
  end,
  event = "WinNew",
  module = "window-picker",
}
