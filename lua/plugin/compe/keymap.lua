local keymap = require("lib.keymap")
local on = keymap.on_press
local opt = keymap.opt

keymap.bind({
  on("<Tab>", "i"):run("v:lua.tab_complete()"),
  on("<Tab>", "s"):run("v:lua.tab_complete()"),
  on("<S-Tab>", "i"):run("v:lua.s_tab_complete()"),
  on("<S-Tab>", "s"):run("v:lua.s_tab_complete()"),
  on("<C-Space>", "i"):run("compe#complete()"):with(opt():noremap():expr()),
  on("<CR>", "i"):run("compe#confirm({ 'keys': '<CR>', 'select': v:true })"),
  on("<C-e>", "i"):run("compe#close('<C-e>')"),
  on("<C-f>", "i"):run("compe#scroll({ 'delta': +4 })"),
  on("<C-d>", "i"):run("compe#scroll({ 'delta': -4 })"),
}, { options = opt():expr() })
