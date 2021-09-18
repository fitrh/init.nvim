local gitsigns = require("gitsigns")
local sign = require("helper.sign")

gitsigns.setup({
  signs = {
    add = { text = sign.line.HEAVY },
    change = { text = sign.line.HEAVY },
    delete = { text = sign.line.HEAVY },
    topdelete = { text = sign.line.HEAVY },
    changedelete = { text = sign.line.HEAVY },
  },
  keymaps = {}, -- disable default keymap
  on_attach = require("plugin.gitsigns.keymap").on_attach,
  preview_config = { border = "rounded" },
  current_line_blame = true,
  current_line_blame_opts = { delay = 250 },
})
