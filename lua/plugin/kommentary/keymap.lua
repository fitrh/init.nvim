local keymap = require("lib.keymap")
local lead = keymap.on_press_leader

keymap.bind({
  lead("/", "n"):plug("kommentary_line_default"),
  lead("/", "v"):plug("kommentary_visual_default"),
  lead("c", "n"):plug("kommentary_motion_default"),
  lead("cic", "n"):plug("kommentary_line_increase"),
  lead("ci", "n"):plug("kommentary_motion_increase"),
  lead("ci", "v"):plug("kommentary_visual_increase"),
  lead("cdc", "n"):plug("kommentary_line_decrease"),
  lead("cd", "n"):plug("kommentary_motion_decrease"),
  lead("cd", "v"):plug("kommentary_visual_decrease"),
})
