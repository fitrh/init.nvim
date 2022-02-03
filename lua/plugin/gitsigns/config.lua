local gitsigns = require("gitsigns")
local sign = require("helper.sign")
local formatter = require("plugin.gitsigns.formatter")

gitsigns.setup({
  signs = {
    add = { text = sign.line.SHADE.light },
    change = { text = sign.line.SHADE.light },
    delete = { text = sign.line.SHADE.light },
    topdelete = { text = sign.line.SHADE.light },
    changedelete = { text = sign.line.SHADE.light },
  },
  on_attach = function(bufnr)
    -- NOTE: Wokraround until gitsigns command accept args
    require("lib.command").add("Blame", function()
      gitsigns.blame_line({ full = true })
    end, { buf = bufnr })
    require("plugin.gitsigns.keymap").attach(bufnr)
  end,
  preview_config = { border = "rounded" },
  current_line_blame = true,
  current_line_blame_opts = { delay = 250 },
  current_line_blame_formatter = formatter.current_line_blame,
})
