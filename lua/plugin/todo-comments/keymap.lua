local keymap = require("lib.keymap")
local on = keymap.on_press

keymap.bind({
  on("[tq", "n"):exec("TodoQuickFix"),
  on("[tl", "n"):exec("TodoLocList"),
  on("[tt", "n"):exec("TodoTrouble"),
  on("[lc", "n"):exec("TodoTelescope theme=ivy previewer=false"),
}, {
  options = keymap.opt():noremap(),
})
