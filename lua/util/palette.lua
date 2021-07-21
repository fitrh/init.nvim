local scheme = require("tokyonight.colors").setup()
local util = require("tokyonight.util")

local M = {
  red = scheme.red,
  red_br_2 = util.brighten(scheme.red, 0.2),
  red1 = scheme.red1,
  blue = scheme.blue,
  blue2 = scheme.blue2,
  blue5 = scheme.blue5,
  teal = scheme.teal,
  cyan = scheme.cyan,
  purple = scheme.purple,
  gitsigns = {
    add = scheme.gitSigns.add,
    change = scheme.gitSigns.change,
    delete = scheme.gitSigns.delete,
  },
  bg_statusline = scheme.bg_statusline,
}

return M
