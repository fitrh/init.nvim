return {
  "nvim-telescope/telescope.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    require("plugin.telescope.config")
    require("plugin.telescope.keymap")
  end,
  cmd = "Telescope",
  keys = {
    "[]",
    "[p",
    "[f",
    "[ld",
    "[lD",
    "[ls",
    "[lS",
    "<Leader>e",
    "<Leader>ft",
    "<Leader>gf",
    "<Leader>gs",
  },
}
