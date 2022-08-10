return {
  "folke/trouble.nvim",
  requires = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require("config.plugin.trouble.setup")
    require("config.plugin.trouble.keymap")
  end,
  cmd = {
    "Trouble",
    "TroubleClose",
    "TroubleToggle",
    "TroubleRefresh",
  },
  ft = { "qf" },
  keys = {
    { "n", "[xx" },
    { "n", "[xd" },
    { "n", "[xw" },
    { "n", "[xl" },
    { "n", "[xq" },
    { "n", "[xr" },
    { "n", "[xD" },
    { "n", "[xt" },
    { "n", "[xR" },
  },
  event = { "DiagnosticChanged" },
}
