local scheme = require("tokyonight.colors").setup({
  style = "night",
  lualineBold = false,
  darkFloat = false,
  darkSidebar = false,
  sidebars = { "Outline" },
})
local util = require("tokyonight.util")

local Palette = {}

Palette.black = {
  primary = scheme.bg,
  secondary = scheme.bg_highlight,
  accent = scheme.terminal_black,
  bright = scheme.fg_dark,
  brighter = scheme.dark3,
  dark = scheme.bg_dark,
  darker = scheme.bg_dark,
}

Palette.red = {
  primary = scheme.red,
  secondary = scheme.red1,
  accent = scheme.git.delete,
  bright = scheme.red1,
  brighter = util.brighten(scheme.red, 0.2),
  dark = scheme.gitSigns.delete,
  darker = scheme.gitSigns.delete,
}

Palette.green = {
  primary = scheme.green,
  secondary = scheme.teal,
  accent = scheme.green1,
  bright = scheme.green1,
  brighter = scheme.green1,
  dark = scheme.green2,
  darker = scheme.gitSigns.add,
}

Palette.yellow = {
  primary = scheme.yellow,
  secondary = scheme.orange,
  accent = scheme.yellow,
  bright = scheme.yellow,
  brighter = scheme.yellow,
  dark = scheme.orange,
  darker = scheme.orange,
}

Palette.blue = {
  primary = scheme.blue,
  secondary = scheme.cyan,
  accent = scheme.blue0,
  bright = scheme.blue5,
  brighter = scheme.blue6,
  dark = scheme.blue1,
  darker = scheme.blue7,
}

Palette.magenta = {
  primary = scheme.magenta,
  secondary = scheme.purple,
  accent = scheme.magenta2,
  bright = scheme.magenta,
  brighter = scheme.magenta,
  dark = scheme.purple,
  darker = scheme.purple,
}

Palette.cyan = {
  primary = scheme.cyan,
  secondary = scheme.blue6,
  accent = scheme.cyan,
  bright = scheme.cyan,
  brighter = scheme.cyan,
  dark = scheme.cyan,
  darker = scheme.blue2,
}

Palette.white = {
  primary = scheme.fg,
  secondary = scheme.fg_dark,
  accent = scheme.fg_gutter,
  bright = scheme.fg,
  brighter = scheme.fg,
  dark = scheme.fg_dark,
  darker = scheme.comment,
}

Palette.fg = {
  primary = scheme.fg,
  secondary = scheme.fg_dark,
  accent = scheme.fg_gutter,
  bright = scheme.fg,
  brighter = scheme.fg,
  dark = scheme.fg_dark,
  darker = scheme.comment,
}

Palette.bg = {
  primary = scheme.bg,
  secondary = scheme.bg_highlight,
  accent = scheme.terminal_black,
  bright = scheme.fg_dark,
  brighter = scheme.dark3,
  dark = scheme.bg_dark,
  darker = scheme.bg_dark,
}

Palette.diff = {
  added = scheme.gitSigns.add,
  changed = scheme.gitSigns.change,
  deleted = scheme.gitSigns.delete,
}

Palette.status = {
  info = scheme.blue2,
  warning = scheme.yellow,
  hint = scheme.teal,
  error = scheme.red1,
}

return Palette
