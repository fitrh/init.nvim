local keymap = require("util.keymap")
local on = keymap.on_press
local opt = keymap.opt

keymap.bind({
  on("f", "n"):exec("HopWord"):with(opt():noremap()),
  on("f", "v"):exec("HopWord"):with(opt():noremap()),
  on("F", "n"):exec("HopLine"):with(opt():noremap()),
  on("F", "v"):exec("HopLine"):with(opt():noremap()),
  on("<M-f>", "n"):exec("HopPattern"):with(opt():noremap()),
  on("<M-f>", "v"):exec("HopPattern"):with(opt():noremap()),
})
