return {
  "rcarriga/nvim-notify",
  config = function()
    require("config.plugin.notify.setup")
  end,
  event = { "BufNew", "BufNewFile", "BufRead" },
}
