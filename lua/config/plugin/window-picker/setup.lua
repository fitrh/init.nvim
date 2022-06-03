local window = require("window-picker")
local hi = require("sugar.highlight")
local config = {}

config.exclude = { Trouble = true }
config.flash_duration = 0 -- 0 means disable flash
window.setup(config)

hi.set("WindowPicker", { inherit = "StatusLine", bold = true, standout = true })

vim.keymap.set("n", "[w", window.pick)
