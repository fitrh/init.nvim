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
  signcolumn = false,
  numhl = true,
  on_attach = function(bufnr)
    require("config.plugin.gitsigns.keymap").attach(gitsigns, bufnr)

    local hi = require("sugar.highlight")
    local bottom = hi.bg("LineNr", { "Normal", "SignColumn", "NormalFloat" })

    for _, kind in ipairs({ "Add", "Change", "Delete" }) do
      local group = ("GitSigns%sNr"):format(kind)
      local inherit = ("GitSigns%s"):format(kind)
      local bg = hi.blend(hi.fg(inherit), bottom, 0.1)
      hi.set(group, { inherit = inherit, bg = bg })
    end
  end,
  preview_config = { border = "rounded" },
  current_line_blame = true,
  current_line_blame_opts = { delay = 250 },
  current_line_blame_formatter = " ﰖ <author>, <author_time:%Y-%m-%d> - <summary>",
})
