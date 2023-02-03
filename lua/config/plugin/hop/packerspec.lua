return {
  "phaazon/hop.nvim",
  config = function()
    require("config.plugin.hop.setup")
    require("config.plugin.hop.keymap")
  end,
  keys = {
    "f/",
    "ff",
    "fw",
    "fb",
    "fh",
    "fj",
    "fk",
    "fl",
    "F/",
    "Fh",
    "Fj",
    "Fk",
    "Fl",
  },
}
