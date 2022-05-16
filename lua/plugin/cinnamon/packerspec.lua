return {
  "declancm/cinnamon.nvim",
  config = function()
    require("plugin.cinnamon.config")
  end,
  keys = {
    "*",
    "g*",
    "#",
    "g#",
    "n",
    "N",
    "gg",
    "G",
    "}",
    "{",
    "<C-u>",
    "<C-d>",
    "<C-f>",
    "<C-b>",
    "<C-y>",
    "<C-e>",
    "<C-o>",
    "<C-i>",
    "zt",
    "zz",
    "zb",
    "ze",
    "zs",
    "zl",
    "zL",
    "zh",
    "zH"
  },
  event = "WinScrolled"
}
