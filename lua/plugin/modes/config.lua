local palette = require("helper.palette")

require("modes").setup({
  colors = {
    copy = palette.orange,
    delete = palette.red,
    insert = palette.bg_highlight,
    visual = palette.purple,
  },
  line_opacity = 0.15,
})
