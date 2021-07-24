local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "┃" },
    topdelete    = { text = "┃" },
    changedelete = { text = "┃" },
  },
  current_line_blame = true,
  current_line_blame_delay = 300, -- in ms
  keymaps = {}, -- disable default keymap
  on_attach = require("plugin.gitsigns.keymap").on_attach,
})
