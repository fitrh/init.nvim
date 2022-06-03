local notify = require("notify")
local sign = require("const.DIAGNOSTIC_SIGN")
local config = {}

config.max_width = function()
  return math.floor(math.max(vim.api.nvim_get_option("columns") / 3, 20))
end

config.max_height = function()
  return math.floor(math.max(vim.api.nvim_get_option("lines") / 3, 4))
end

config.level = "TRACE"
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
