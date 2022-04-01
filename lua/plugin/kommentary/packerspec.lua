return {
  "b3nj5m1n/kommentary",
  config = function()
    require("plugin.kommentary.config")
    require("plugin.kommentary.keymap")
  end,
  setup = function()
    vim.g.kommentary_create_default_mappings = false
  end,
  keys = {
    "<Plug>kommentary_line_default",
    "<Plug>kommentary_visual_default",
    "<Plug>kommentary_motion_default",
    { "n", "<Leader>/" },
    { "v", "<Leader>/" },
    { "n", "<Leader>c" },
    { "v", "<Leader>ci" },
    { "v", "<Leader>cd" },
  },
}