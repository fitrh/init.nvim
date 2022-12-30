local keymap = require("sugar.keymap")
local map, modifier, mode = keymap.map, keymap.modifier, keymap.mode
local leader, plug = modifier.leader, modifier.plug
local n, v = mode.normal, mode.visual

keymap.bind({
  n(map(leader("/"), plug("kommentary_line_default"))),
  v(map(leader("/"), plug("kommentary_visual_default"))),
  n(map(leader("c"), plug("kommentary_motion_default"))),
})
