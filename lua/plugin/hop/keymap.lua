local keymap = require("sugar.keymap")
local map, ex = keymap.map, keymap.modifier.ex

keymap.bind({
  map("f/", ex("HopPattern")),
  map("ff", ex("HopWord")),
  map("fw", ex("HopWordMW")),
  map("fj", ex("HopChar2AC")),
  map("fk", ex("HopChar2BC")),
  map("fl", ex("HopChar2CurrentLineAC")),
  map("fh", ex("HopChar2CurrentLineBC")),
  map("Fj", ex("HopWordAC")),
  map("Fk", ex("HopWordBC")),
  map("Fl", ex("HopWordCurrentLineAC")),
  map("Fh", ex("HopWordCurrentLineBC")),
})
