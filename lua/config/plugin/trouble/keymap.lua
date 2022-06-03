local key = require("sugar.keymap")
local map, n = key.map, key.mode.normal

local trouble = require("trouble")

key.bind({
  n(map("[xx", trouble.toggle)),
  n(map("[xd", function()
    trouble.toggle("document_diagnostics")
  end)),
  n(map("[xw", function()
    trouble.toggle("workspace_diagnostics")
  end)),
  n(map("[xl", function()
    trouble.toggle("loclist")
  end)),
  n(map("[xq", function()
    trouble.toggle("quickfix")
  end)),
  n(map("[xr", function()
    trouble.toggle("lsp_references")
  end)),
  n(map("[xD", function()
    trouble.toggle("lsp_definitions")
  end)),
  n(map("[xt", function()
    trouble.toggle("lsp_type_definitions")
  end)),
  n(map("[xR", trouble.refresh)),
})
