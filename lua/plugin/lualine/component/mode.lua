local palette = require("plugin.themes.palette")
local hl = require("lib.highlight")
local fmt = require("plugin.lualine.component.util.fmt")

local modes = {
  n = { text = "NRM", color = palette.blue },
  nt = { text = "N·T", color = palette.blue },
  i = { text = "INS", color = palette.green.primary },
  ix = { text = "I·X", color = palette.green.primary }, -- i_CTRL-N
  ic = { text = "I·C", color = palette.green.primary }, -- i_CTRL-X
  v = { text = "VIS", color = palette.purple },
  [""] = { text = "V·B", color = palette.purple },
  V = { text = "V·L", color = palette.purple },
  c = { text = "CMD", color = palette.yellow },
  s = { text = "SEL", color = palette.purple },
  S = { text = "S·L", color = palette.purple },
  [""] = { text = "S·B", color = palette.purple },
  R = { text = "REP", color = palette.red },
  Rv = { text = "R·V", color = palette.red }, -- gR
  t = { text = "TRM", color = palette.red },
}

return {
  function()
    local mode = modes[vim.api.nvim_get_mode().mode]
    hl.set("ModeState", { fg = mode.color, bg = palette.bg_statusline })
    hl.set("LualineComponentMode", { inherit = "ModeState", bold = true })
    return mode.text
  end,
  color = "LualineComponentMode",
  fmt = function(str)
    return fmt.show_on_width(80, str, string.sub(str, 1, 1))
  end,
}
