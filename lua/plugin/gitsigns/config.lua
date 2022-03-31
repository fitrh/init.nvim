local gitsigns = require("gitsigns")
local sign = require("const.LINE_CHAR")

gitsigns.setup({
  signs = {
    add = { text = sign.SHADE.light },
    change = { text = sign.SHADE.light },
    delete = { text = sign.SHADE.light },
    topdelete = { text = sign.SHADE.light },
    changedelete = { text = sign.SHADE.light },
  },
  on_attach = function(bufnr)
    require("plugin.gitsigns.keymap").attach(gitsigns, bufnr)
  end,
  preview_config = { border = "rounded" },
  current_line_blame = true,
  current_line_blame_opts = { delay = 250 },
  current_line_blame_formatter = " ﰖ <author>, <author_time:%Y-%m-%d> - <summary>",
})
