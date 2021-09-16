local gitsigns = require("gitsigns")
local sign = require("helper.sign")

gitsigns.setup({
  signs = {
    add = { text = sign.line.heavy },
    change = { text = sign.line.heavy },
    delete = { text = sign.line.heavy },
    topdelete = { text = sign.line.heavy },
    changedelete = { text = sign.line.heavy },
  },
  keymaps = {}, -- disable default keymap
  on_attach = require("plugin.gitsigns.keymap").on_attach,
  preview_config = { border = "rounded" },
  current_line_blame = true,
  current_line_blame_opts = { delay = 250 },
})
