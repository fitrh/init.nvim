return {
  "nvim-telescope/telescope.nvim",
  requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  config = function() require("plugin.telescope.config") end,
  cmd = "Telescope",
}
