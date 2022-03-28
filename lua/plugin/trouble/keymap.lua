local key = require("sugar.keymap")
local map, n, ex = key.map, key.mode.normal, key.modifier.ex

key.bind({
  n(map("[xx", ex("TroubleToggle"))),
  n(map("[xd", ex("TroubleToggle document_diagnostics"))),
  n(map("[xw", ex("TroubleToggle workspace_diagnostics"))),
  n(map("[xl", ex("TroubleToggle loclist"))),
  n(map("[xq", ex("TroubleToggle quickfix"))),
  n(map("[xr", ex("TroubleToggle lsp_references"))),
  n(map("[xD", ex("TroubleToggle lsp_definitions"))),
  n(map("[xt", ex("TroubleToggle lsp_type_definitions"))),
  n(map("[xR", ex("TroubleRefresh"))),
})
