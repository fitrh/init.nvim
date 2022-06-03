local M = {
  "lewis6991/gitsigns.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    require("config.plugin.gitsigns.setup")
  end,
  keys = { "gs", "]c", "]C", "[c", "[C" },
  module = "gitsigns",
}

return M
