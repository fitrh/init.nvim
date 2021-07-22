local M = {
  "lewis6991/gitsigns.nvim",
  requires = { { "nvim-lua/plenary.nvim", module = "plenary" } },
  config = function() require("plugin.gitsigns.config") end,
  keys = "gs",
}

return M