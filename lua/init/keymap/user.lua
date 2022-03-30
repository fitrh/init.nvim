local keymap = require("sugar.keymap")
local map, mode, modifier = keymap.map, keymap.mode, keymap.modifier
local n = mode.normal
local leader, ex = modifier.leader, modifier.ex

keymap.bind({
  -- Minimal tmux Integration behavior
  n(map("<M-h>", ex("TmuxMoveH"))),
  n(map("<M-j>", ex("TmuxMoveJ"))),
  n(map("<M-k>", ex("TmuxMoveK"))),
  n(map("<M-l>", ex("TmuxMoveL"))),

  -- Minimal zen mode behavior
  n(map(leader("zz"), ex("ZenToggleFull"))),
  n(map(leader("nr"), ex("ZenToggle"))),
})
