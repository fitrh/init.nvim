local keymap = require("lib.keymap")
local on = keymap.on_press
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({
  -- Minimal tmux Integration behavior
  on("<M-h>", "n"):exec("TmuxMoveH"),
  on("<M-j>", "n"):exec("TmuxMoveJ"),
  on("<M-k>", "n"):exec("TmuxMoveK"),
  on("<M-l>", "n"):exec("TmuxMoveL"),

  -- Minimal zen mode behavior
  lead("zz", "n"):exec("ZenToggleFull"),
  lead("nr", "n"):exec("ZenToggle"),
}, {
  options = opt():noremap(),
})
