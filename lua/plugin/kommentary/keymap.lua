local keymap = require("util.keymap")
local on = keymap.on_press
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({
  lead("/", "n"):plug("kommentary_line_default"),
  lead("/", "v"):plug("kommentary_visual_default"),
  lead("c", "n"):plug("kommentary_motion_default"),
})
