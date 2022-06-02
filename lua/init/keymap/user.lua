local keymap = require("sugar.keymap")
local map, mode = keymap.map, keymap.mode
local n = mode.normal

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
  n(map("gZ", function()
    require("helper.zen").enter()
  end)),
  n(map("gzz", function()
    require("helper.zen").enter({ show = { laststatus = true } })
  end)),
})
