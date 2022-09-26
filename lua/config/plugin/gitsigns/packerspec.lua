local M = {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("config.plugin.gitsigns.setup")
  end,
  keys = { "gs", "]c", "]C", "[c", "[C" },
}

return M
