local gitsigns = require("gitsigns")
local sign = require("const.LINE_CHAR")

gitsigns.setup({
  signs = {
    add = { text = sign.SHADE.medium },
    change = { text = sign.SHADE.medium },
    delete = { text = sign.SHADE.medium },
    topdelete = { text = sign.SHADE.medium },
    changedelete = { text = sign.SHADE.medium },
  },
  on_attach = function(bufnr)
    require("config.plugin.gitsigns.keymap").attach(gitsigns, bufnr)
  end,
  preview_config = { border = "rounded" },
  current_line_blame = true,
  current_line_blame_opts = { delay = 250 },
  current_line_blame_formatter = " ﰖ <author>, <author_time:%Y-%m-%d> - <summary>",
})
