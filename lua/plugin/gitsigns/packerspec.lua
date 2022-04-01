local M = {
  "lewis6991/gitsigns.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    require("plugin.gitsigns.config")
  end,
  keys = { "gs", "]c", "[c" },
  module = "gitsigns",
}

return M
