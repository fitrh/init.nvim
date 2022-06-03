return {
  "monaqa/dial.nvim",
  config = function()
    require("config.plugin.dial.setup")
    require("config.plugin.dial.keymap")
  end,
  keys = {
    { "n", "<C-a>" },
    { "n", "<C-x>" },
    { "v", "<C-a>" },
    { "v", "<C-x>" },
    { "v", "g<C-a>" },
    { "v", "g<C-x>" },
  },
}
