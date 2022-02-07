local notify = require("notify")
local sign = require("helper.sign").diagnostic
local config = {}

config.max_width = math.floor(vim.api.nvim_win_get_width(0) / 3)
config.max_height = math.floor(vim.api.nvim_win_get_height(0) / 3)
config.timeout = 3000
config.icons = {
  ERROR = sign.ERROR,
  WARN = sign.WARN,
  INFO = sign.INFO,
  DEBUG = "",
  TRACE = "",
}
notify.setup(config)
vim.notify = notify
