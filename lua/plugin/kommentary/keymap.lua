local keymap = require("sugar.keymap")
local map, modifier, mode = keymap.map, keymap.modifier, keymap.mode
local leader, plug = modifier.leader, modifier.ex
local n, v = mode.normal, mode.vselect

keymap.bind({
  n(map(leader("/"), plug("kommentary_line_default"))),
  v(map(leader("/"), plug("kommentary_line_default"))),
  n(map(leader("c"), plug("kommentary_motion_default"))),
  n(map(leader("cic"), plug("kommentary_line_increase"))),
  n(map(leader("ci"), plug("kommentary_motion_increase"))),
  v(map(leader("ci"), plug("kommentary_visual_increase"))),
  n(map(leader("cdc"), plug("kommentary_line_decrease"))),
  n(map(leader("cd"), plug("kommentary_motion_decrease"))),
  v(map(leader("cd"), plug("kommentary_visual_decrease"))),
})
