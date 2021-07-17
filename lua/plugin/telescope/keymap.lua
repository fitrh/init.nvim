local keymap = require("util.keymap")
local on = keymap.on_press
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({
  lead("bl", "n"):exec("Telescope buffers"):with(opt():noremap()),
  on("<C-p>"):exec("Telescope find_files"):with(opt():noremap()),
  lead("e"):exec("Telescope file_browser"):with(opt():noremap()),
  on("<C-f>"):exec("Telescope live_grep"):with(opt():noremap()),
  lead("ft"):exec("Telescope filetypes"):with(opt():noremap()),
  lead("lo"):exec("Telescope treesitter"):with(opt():noremap()),
  lead("gf", "n"):exec("Telescope git_files"):with(opt():noremap()),
  lead("gc", "n"):exec("Telescope git_commits"):with(opt():noremap()),
  lead("gb", "n"):exec("Telescope git_branches"):with(opt():noremap()),
  lead("gs", "n"):exec("Telescope git_status"):with(opt():noremap()),
  lead("m", "n"):exec("Telescope keymaps"):with(opt():noremap()),
})
