return {
  "b0o/incline.nvim",
  config = function()
    require("plugin.incline.config")
  end,
  event = { "WinNew" },
}
