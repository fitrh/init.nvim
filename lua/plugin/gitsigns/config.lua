local gitsigns = require("gitsigns")
local sign = require("helper.sign")
local formatter = require("plugin.gitsigns.formatter")

gitsigns.setup({
  signs = {
    add = { text = sign.line.HEAVY },
    change = { text = sign.line.HEAVY },
    delete = { text = sign.line.HEAVY },
    topdelete = { text = sign.line.HEAVY },
    changedelete = { text = sign.line.HEAVY },
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
