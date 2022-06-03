return {
  "j-hui/fidget.nvim",
  config = function()
    require("config.plugin.fidget.setup")
  end,
  event = { "BufNew", "BufNewFile", "BufRead" },
  module = "fidget",
}
