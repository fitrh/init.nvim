local keymap = require("lib.keymap")
local on = keymap.on_press
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({
  lead("j"):exec("HopWord"),
  on("f"):exec("HopChar2"),
  on("F"):exec("HopLineStart"),
  on("<M-f>"):exec("HopPattern"),
}, { options = opt():noremap() })
