local config = {
  level = "TRACE",
  timeout = 2500,
  max_width = function()
    return math.floor(math.max(vim.api.nvim_get_option("columns") / 2, 20))
  end,
  max_height = function()
    return math.floor(math.max(vim.api.nvim_get_option("lines") / 3, 4))
  end,
  render = "minimal",
  minimum_width = 30,
  top_down = false,
}

local sign = require("const.DIAGNOSTIC_SIGN")
config.icons = {
  ERROR = sign.ERROR,
  WARN = sign.WARN,
  INFO = sign.INFO,
  DEBUG = "",
  TRACE = "",
}

local notify = require("notify")
notify.setup(config)
vim.notify = notify
