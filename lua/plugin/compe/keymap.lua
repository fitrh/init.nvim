local keymap = require("util.keymap")
local on = keymap.on_press
local opt = keymap.opt

keymap.bind({
  on("<Tab>", "i"):run("v:lua.tab_complete()"):with(opt():expr()),
  on("<Tab>", "s"):run("v:lua.tab_complete()"):with(opt():expr()),
  on("<S-Tab>", "i"):run("v:lua.s_tab_complete()"):with(opt():expr()),
  on("<S-Tab>", "s"):run("v:lua.s_tab_complete()"):with(opt():expr()),
  on("<C-Space>", "i"):run("compe#complete()"):with(opt():noremap():expr()),
  -- on("<CR>", "i"):run("compe#confirm('<CR>')"):with(opt():expr()),
  -- on("<CR>", "i"):run(
  --   [[compe#confirm(luaeval('require "nvim-autopairs".autopairs_cr()'))]]
  -- ):with(opt():expr()),
  on("<C-e>", "i"):run("compe#close('<C-e>')"):with(opt():expr()),
  on("<C-f>", "i"):run("compe#scroll({ 'delta': +4 })"):with(opt():expr()),
  on("<C-d>", "i"):run("compe#scroll({ 'delta': -4 })"):with(opt():expr()),
})
