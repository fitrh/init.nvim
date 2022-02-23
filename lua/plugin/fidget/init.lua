return {
  "j-hui/fidget.nvim",
  config = function()
    require("plugin.fidget.config")
  end,
  event = { "BufNew", "BufNewFile", "BufRead" },
  module = "fidget",
}
