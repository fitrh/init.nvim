local keymap = require("util.keymap")
local on = keymap.on_press
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({

  -- Minimal tmux Integration behavior
  on("<M-h>", "n"):lua([[require("util.tmux").move("h")]]),
  on("<M-j>", "n"):lua([[require("util.tmux").move("j")]]),
  on("<M-k>", "n"):lua([[require("util.tmux").move("k")]]),
  on("<M-l>", "n"):lua([[require("util.tmux").move("l")]]),

  -- Minimal zen mode behavior
  lead("zz", "n"):lua('require("util.zen").toggle({ laststatus = true })'),
  lead("nr", "n"):lua('require("util.zen").toggle()'),

}, { options = opt():noremap() })
