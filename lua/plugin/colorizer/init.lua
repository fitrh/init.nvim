local M = {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("plugin.colorizer.config")
    require("plugin.colorizer.keymap")
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
