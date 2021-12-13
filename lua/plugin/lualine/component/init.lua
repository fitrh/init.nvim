local M = {}

function M.spacer(width)
  width = width or 1
  return {
    function()
      return string.rep(" ", width)
    end,
    padding = 0,
  }
end

M.mode = require("plugin.lualine.component.mode")
M.file = require("plugin.lualine.component.file")
M.state = require("plugin.lualine.component.state")
M.git = require("plugin.lualine.component.git")

return M
