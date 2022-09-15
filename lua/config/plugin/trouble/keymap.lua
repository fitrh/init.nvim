local key = require("sugar.keymap")
local map, n = key.map, key.mode.normal

key.bind({
  n(map("[xx", function()
    require("trouble").toggle()
  end)),
  n(map("[xd", function()
    require("trouble").toggle("document_diagnostics")
  end)),
  n(map("[xw", function()
    require("trouble").toggle("workspace_diagnostics")
  end)),
  n(map("[xl", function()
    require("trouble").toggle("loclist")
  end)),
  n(map("[xq", function()
    require("trouble").toggle("quickfix")
  end)),
  n(map("[xr", function()
    require("trouble").toggle("lsp_references")
  end)),
  n(map("[xD", function()
    require("trouble").toggle("lsp_definitions")
  end)),
  n(map("[xt", function()
    require("trouble").toggle("lsp_type_definitions")
  end)),
  n(map("[xR", function()
    require("trouble").refresh()
  end)),
})
