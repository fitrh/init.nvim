local M = {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("plugin.colorizer.config")
  end,
  cmd = {
    "ColorizerAttachToBuffer",
    "ColorizerDetachFromBuffer",
    "ColorizerReloadAllBuffers",
    "ColorizerToggle",
  },
}

return M
