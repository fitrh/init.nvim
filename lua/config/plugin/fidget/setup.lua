local fidget = require("fidget")
local config = {}

config.text = {
  spinner = "dots",
  done = "✓",
}

config.window = {
  relative = "editor",
  blend = vim.api.nvim_get_option("pumblend"),
}

fidget.setup(config)
