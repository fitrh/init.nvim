return {
  "rcarriga/nvim-notify",
  config = function()
    require("plugin.notify.config")
  end,
  event = { "BufNew", "BufNewFile", "BufRead" },
}
