local keymap = require("sugar.keymap")
local map, mode, modifier = keymap.map, keymap.mode, keymap.modifier
local n = mode.normal
local leader = modifier.leader

keymap.bind({
  -- Minimal tmux Integration behavior
  n(map("<M-h>", function()
    require("helper.tmux").move("h")
  end)),
  n(map("<M-j>", function()
    require("helper.tmux").move("j")
  end)),
  n(map("<M-k>", function()
    require("helper.tmux").move("k")
  end)),
  n(map("<M-l>", function()
    require("helper.tmux").move("l")
  end)),

  -- Minimal zen mode behavior
  n(map(leader("zz"), function()
    require("helper.zen").toggle()
  end)),
  n(map(leader("nr"), function()
    require("helper.zen").toggle({ laststatus = true })
  end)),
})
