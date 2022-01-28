local fidget = require("fidget")
local config = {}

config.text = {
  spinner = {
    "   ",
    ".  ",
    ".. ",
    "...",
    " ..",
    "  .",
    "   ",
    "  .",
    " ..",
    "...",
    ".. ",
    ".  ",
  },
  done = "",
}

fidget.setup(config)
