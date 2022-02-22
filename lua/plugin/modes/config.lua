local palette = require("plugin.themes.palette")

require("modes").setup({
  colors = {
    copy = palette.yellow.primary,
    delete = palette.red.primary,
    insert = palette.fg.secondary,
    visual = palette.magenta.secondary,
  },
  line_opacity = { insert = 0, visual = 0.2 },
  focus_only = true,
})
