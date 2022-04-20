return {
  "monaqa/dial.nvim",
  config = function()
    require("plugin.dial.config")
    require("plugin.dial.keymap")
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
