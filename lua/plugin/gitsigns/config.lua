local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "┃" },
    topdelete    = { text = "┃" },
    changedelete = { text = "┃" },
  },
  keymaps = {}, -- disable default keymap
  on_attach = require("plugin.gitsigns.keymap").on_attach,
  preview_config = { border = "rounded", },
  current_line_blame = true,
  current_line_blame_opts = { delay = 250, },
})
