local M = {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("config.plugin.colorizer.setup")
    require("config.plugin.colorizer.keymap")
  end,
  cmd = {
    "ColorizerAttachToBuffer",
    "ColorizerDetachFromBuffer",
    "ColorizerReloadAllBuffers",
    "ColorizerToggle",
  },
  keys = "<Leader>cc",
}

return M
