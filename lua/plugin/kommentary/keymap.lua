local keymap = require("lib.keymap")
local lead = keymap.on_press_leader

keymap.bind({
  lead("/", "n"):plug("kommentary_line_default"),
  lead("/", "v"):plug("kommentary_visual_default"),
  lead("c", "n"):plug("kommentary_motion_default"),
})
