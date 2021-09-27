local keymap = require("lib.keymap")
local on = keymap.on_press
local opt = keymap.opt

keymap.bind({
  on("[cr", "n"):exec("CratesRefresh"),
  on("[cc", "n"):exec("CratesToggle"),
  on("[cR", "n"):exec("CratesReload"),
  on("[ch", "n"):exec("CratesHide"),
  on("[cu", "n"):exec("CratesUpdate"),
  on("[cu", "v"):exec("CratesUpdates"),
  on("[ca", "n"):exec("CratesUpdateAll"),
  on("[cU", "n"):exec("CratesUpgrade"),
  on("[cU", "v"):exec("CratesUpgrades"),
  on("[cA", "n"):exec("CratesUpgradeAll"),
  on("[cp", "n"):exec("CratesShowPopup"),
  on("[cP", "n"):exec("CratesHidePopup"),
}, {
  options = opt():noremap(),
})
