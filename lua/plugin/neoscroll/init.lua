return {
  "karb94/neoscroll.nvim",
  config = function()
    require("plugin.neoscroll.config")
  end,
  keys = {
    "<C-u>",
    "<C-d>",
    "<C-f>",
    "<C-b>",
    "<C-y>",
    "<C-e>",
    "zt",
    "zz",
    "zb",
  },
}
