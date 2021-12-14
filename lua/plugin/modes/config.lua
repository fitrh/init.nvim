local palette = require("plugin.themes.palette")

require("modes").setup({
  colors = {
    copy = palette.orange,
    delete = palette.red,
    insert = palette.fg_dark,
    visual = palette.purple,
  },
  line_opacity = { insert = 0, visual = 0.2 },
  focus_only = true,
})
