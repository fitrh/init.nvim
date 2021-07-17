return {
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-lua/popup.nvim", module = "popup" },
    { "nvim-lua/plenary.nvim", module = "plenary" },
  },
  config = function() require("plugin.telescope.config") end,
  cmd = "Telescope",
  module = "telescope",
}
