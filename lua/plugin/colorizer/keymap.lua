local keymap = require("lib.keymap")
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({
  lead("cc"):exec("ColorizerToggle"):with(opt():noremap())
})
