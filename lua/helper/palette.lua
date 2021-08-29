local scheme = require("tokyonight.colors").setup({
  style = "night",
  lualineBold = false,
  darkFloat = false,
  darkSidebar = false,
  sidebars = { "Outline" },
})
local util = require("tokyonight.util")

local M = {
  red = scheme.red,
  red_br_2 = util.brighten(scheme.red, 0.2),
  red1 = scheme.red1,
  orange = scheme.orange,
  blue = scheme.blue,
  blue2 = scheme.blue2,
  blue5 = scheme.blue5,
  teal = scheme.teal,
  cyan = scheme.cyan,
  purple = scheme.purple,
  magenta = scheme.magenta,
  gitsigns = {
    add = scheme.gitSigns.add,
    change = scheme.gitSigns.change,
    delete = scheme.gitSigns.delete,
  },
  fg = scheme.fg,
  fg_dark = scheme.fg_dark,
  bg_statusline = scheme.bg_statusline,
  bg_highlight = scheme.bg_highlight,
  bg_visual = scheme.bg_visual,
}

return M
