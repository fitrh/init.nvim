return {
  "b0o/incline.nvim",
  config = function()
    require("config.plugin.incline.setup")
  end,
  event = { "WinNew", "CursorMoved" },
}
