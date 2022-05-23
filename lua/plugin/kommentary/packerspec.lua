return {
  "b3nj5m1n/kommentary",
  config = function()
    require("plugin.kommentary.config")
    require("plugin.kommentary.keymap")
  end,
  keys = {
    "<Plug>kommentary_line_default",
    "<Plug>kommentary_visual_default",
    "<Plug>kommentary_motion_default",
    "gc",
    { "v", "gc" },
    { "n", "<Leader>/" },
    { "v", "<Leader>/" },
    { "n", "<Leader>c" },
    { "v", "<Leader>ci" },
    { "v", "<Leader>cd" },
  },
}
