local config = {}

config.window = {
  options = {
    winblend = vim.api.nvim_get_option("pumblend"),
  },
}

config.hide = {
  focused_win = true,
}

config.highlight = {
  groups = {
    InclineNormal = "StatusLine",
    InclineNormalNC = "StatusLineNC",
  },
}

require("incline").setup(config)
