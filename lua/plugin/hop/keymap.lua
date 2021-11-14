local keymap = require("lib.keymap")
local on = keymap.on_press
local opt = keymap.opt

keymap.bind({
  on("ff"):exec("HopWord"),
  on("fj"):exec("HopChar2AC"),
  on("fk"):exec("HopChar2BC"),
  on("fl"):exec("HopChar2CurrentLineAC"),
  on("fh"):exec("HopChar2CurrentLineBC"),
  on("Fj"):exec("HopWordAC"),
  on("Fk"):exec("HopWordBC"),
  on("Fl"):exec("HopWordCurrentLineAC"),
  on("Fh"):exec("HopWordCurrentLineBC"),
  on("<M-f>"):exec("HopPattern"),
}, {
  options = opt():noremap(),
})
