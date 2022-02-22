local palette = require("plugin.themes.palette")
local config = {}

config.colors = {
  copy = palette.yellow.primary,
  delete = palette.red.primary,
  insert = palette.fg.secondary,
  visual = palette.magenta.secondary,
}
config.line_opacity = { insert = 0, visual = 0.2 }
config.focus_only = true

require("modes").setup(config)
