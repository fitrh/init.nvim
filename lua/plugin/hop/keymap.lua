local keymap = require("util.keymap")
local on = keymap.on_press
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({
  lead("j"):exec("HopWord"):with(opt():noremap()),
  on("f"):exec("HopChar2"):with(opt():noremap()),
  on("F"):exec("HopLineStart"):with(opt():noremap()),
  on("<M-f>"):exec("HopPattern"):with(opt():noremap()),
})
