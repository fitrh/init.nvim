local modes = {
  n = "NRM",
  niI = "N·I", -- i_CTRL_O
  niR = "N·R", -- R_CTRL_O
  niV = "NRV", -- gR_CTRL_O
  nt = "N·T",
  i = "INS",
  ix = "I·X", -- i_CTRL_X
  ic = "I·C", -- i_CTRL_N | i_CTRL_P
  v = "VIS",
  [""] = "V·B",
  V = "V·L",
  vs = "S·V", -- gh_CTRL_O
  Vs = "SVL", -- gH_CTRL_O
  c = "CMD",
  s = "SEL", -- gh
  S = "S·L", -- gH
  [""] = "S·B", -- g_CTRL_H
  R = "REP", -- R
  Rx = "R·X", -- R_CTRL_X
  Rc = "R·C", -- R_CTRL_P
  Rv = "R·V", -- gR
  Rvc = "RVC", -- gR_CTRL_P
  Rvx = "RVX", -- gR_CTRL_X
  t = "TRM",
}

return {
  function()
    local mode = vim.api.nvim_get_mode().mode
    return modes[mode] or mode
  end,
  color = { gui = "BOLD" },
  fmt = function(str)
    local fmt = require("config.plugin.lualine.component.util.fmt")
    return fmt.show_on(80, str, string.sub(str, 1, 1))
  end,
}
