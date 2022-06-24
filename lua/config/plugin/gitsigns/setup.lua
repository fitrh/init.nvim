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

    require("sugar.highlight").colorscheme(function(h)
      local base = h.bg("LineNr", { "Normal", "SignColumn", "NormalFloat" })

      for _, kind in ipairs({ "Add", "Change", "Delete" }) do
        local inherit = ("GitSigns%s"):format(kind)
        h.set(("GitSigns%sNr"):format(kind), {
          inherit = inherit,
          bg = h.blend(h.fg(inherit), base, 0.15),
        })
        h.set(("GitSigns%sLn"):format(kind), {
          bg = h.blend(h.fg(inherit), base, 0.05),
        })
        h.set(("GitSigns%sInline"):format(kind), {
          bg = h.blend(h.fg(inherit), base, 0.25),
        })
      end
    end)
  end,
  preview_config = { border = "rounded" },
  current_line_blame = true,
  current_line_blame_opts = { delay = 250 },
  current_line_blame_formatter = " ﰖ <author>, <author_time:%Y-%m-%d> - <summary>",
})
