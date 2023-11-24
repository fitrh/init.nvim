return {
  "monaqa/dial.nvim",
  config = function()
    require("config.plugin.dial.setup")
    require("config.plugin.dial.keymap")
  end,
  keys = {
    { "n", "<C-a>" },
    { "n", "<C-x>" },
    { "x", "<C-a>" },
    { "x", "<C-x>" },
    { "x", "g<C-a>" },
    { "x", "g<C-x>" },
  },
}
