local notify = require("notify")
local sign = require("helper.sign").diagnostic
local config = {}

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
