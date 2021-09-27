local mod = "lua require('crates')"

require("lib.command").group({
  prefix = "Crates",
  create = {
    { name = "Refresh", cmd = ("%s.update()"):format(mod) },
    { name = "Toggle", cmd = ("%s.toggle()"):format(mod) },
    { name = "Reload", cmd = ("%s.reload()"):format(mod) },
    { name = "Hide", cmd = ("%s.hide()"):format(mod) },
    { name = "Update", cmd = ("%s.update_crate()"):format(mod) },
    { name = "Updates", cmd = ("%s.update_crates()"):format(mod) },
    { name = "UpdateAll", cmd = ("%s.update_all_crates()"):format(mod) },
    { name = "Upgrade", cmd = ("%s.upgrade_crate()"):format(mod) },
    { name = "Upgrades", cmd = ("%s.upgrade_crates()"):format(mod) },
    { name = "UpgradeAll", cmd = ("%s.upgrade_all_crates()"):format(mod) },
    { name = "ShowPopup", cmd = ("%s.show_popup()"):format(mod) },
    { name = "HidePopup", cmd = ("%s.hide_popup()"):format(mod) },
  },
})
