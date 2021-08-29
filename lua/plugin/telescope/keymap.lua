local keymap = require("lib.keymap")
local on = keymap.on_press
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({
  lead("bl", "n"):exec("Telescope buffers"),
  on("<C-p>"):exec("Telescope find_files"),
  lead("e"):exec("Telescope file_browser"),
  on("<C-f>"):exec("Telescope live_grep"),
  lead("ft"):exec("Telescope filetypes"),
  lead("lo"):exec("Telescope treesitter"),
  lead("gf", "n"):exec("Telescope git_files"),
  lead("gc", "n"):exec("Telescope git_commits"),
  lead("gb", "n"):exec("Telescope git_branches"),
  lead("gs", "n"):exec("Telescope git_status"),
  lead("m", "n"):exec("Telescope keymaps"),
}, { options = opt():noremap() })
