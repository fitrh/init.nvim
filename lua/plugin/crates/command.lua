local crates = require("crates")

require("lib.command").group({
  prefix = "Crates",
  cmds = {
    { name = "Refresh", cmd = crates.update },
    { name = "Toggle", cmd = crates.toggle },
    { name = "Reload", cmd = crates.reload },
    { name = "Hide", cmd = crates.hide },
    { name = "Update", cmd = crates.update_crate },
    { name = "Updates", cmd = crates.update_crates },
    { name = "UpdateAll", cmd = crates.update_all_crates },
    { name = "Upgrade", cmd = crates.upgrade_crate },
    { name = "Upgrades", cmd = crates.upgrade_crates },
    { name = "UpgradeAll", cmd = crates.upgrade_all_crates },
    { name = "ShowPopup", cmd = crates.show_popup },
    { name = "HidePopup", cmd = crates.hide_popup },
  },
})
