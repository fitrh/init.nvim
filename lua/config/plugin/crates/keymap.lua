local crates = require("crates")
local keymap = require("sugar.keymap")
local map, mode = keymap.map, keymap.mode
local n, v = mode.normal, mode.visual

keymap.bind({
  n(map("[cr", crates.update)),
  n(map("[cc", crates.toggle)),
  n(map("[cR", crates.reload)),
  n(map("[ch", crates.hide)),
  n(map("[cu", crates.update_crate)),
  v(map("[cu", crates.update_crates)),
  n(map("[ca", crates.update_all_crates)),
  n(map("[cU", crates.upgrade_crate)),
  v(map("[cU", crates.upgrade_crates)),
  n(map("[cA", crates.upgrade_all_crates)),
  n(map("[cp", crates.show_popup)),
  n(map("[cP", crates.hide_popup)),
}, { buffer = true })
