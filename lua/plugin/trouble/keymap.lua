local keymap = require("lib.keymap")
local on = keymap.on_press

keymap.bind({
  on("[xx", "n"):exec("TroubleToggle"),
  on("[xd", "n"):exec("TroubleToggle document_diagnostics"),
  on("[xw", "n"):exec("TroubleToggle workspace_diagnostics"),
  on("[xl", "n"):exec("TroubleToggle loclist"),
  on("[xq", "n"):exec("TroubleToggle quickfix"),
  on("[xr", "n"):exec("TroubleToggle lsp_references"),
  on("[xD", "n"):exec("TroubleToggle lsp_definitions"),
  on("[xt", "n"):exec("TroubleToggle lsp_type_definitions"),
  on("[xR", "n"):exec("TroubleRefresh"),
}, { options = keymap.opt():noremap() })
