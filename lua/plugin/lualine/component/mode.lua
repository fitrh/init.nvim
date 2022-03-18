local fmt = require("plugin.lualine.component.util.fmt")

local modes = {
  n = "NRM",
  nt = "N·T",
  i = "INS",
  ix = "I·X", -- i_CTRL-N
  ic = "I·C", -- i_CTRL-X
  v = "VIS",
  [""] = "V·B",
  V = "V·L",
  c = "CMD",
  s = "SEL",
  S = "S·L",
  [""] = "S·B",
  R = "REP",
  Rv = "R·V", -- gR
  t = "TRM",
}

return {
  function()
    return modes[vim.api.nvim_get_mode().mode]
  end,
  color = { gui = "BOLD" },
  fmt = function(str)
    return fmt.show_on(80, str, string.sub(str, 1, 1))
  end,
}
