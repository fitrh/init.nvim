return {
  "kylechui/nvim-surround",
  config = function()
    require("config.plugin.surround.setup")
  end,
  keys = {
    { "n", "s" },
    { "v", "S" },
    { "v", "g" },
    { "i", "<C-g>s" },
  },
  event = "InsertEnter",
}
