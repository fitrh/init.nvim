local keymap = require("sugar.keymap")
local map, ex, n = keymap.map, keymap.modifier.ex, keymap.mode.normal

keymap.bind({
  n(map("[tq", ex("TodoQuickFix"))),
  n(map("[tl", ex("TodoLocList"))),
  n(map("[tt", ex("TodoTrouble"))),
  n(map("[lc", ex("TodoTelescope theme=ivy previewer=false"))),
})
