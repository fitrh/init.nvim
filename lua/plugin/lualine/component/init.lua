local M = {}

---@param width number
---@return table
function M.spacer(width)
  local spaces = string.rep(" ", width or 1)
  return {
    function()
      return spaces
    end,
    padding = 0,
  }
end

---@alias StripAlignment
---| '"left"' # Left align character -> `▌`.
---| '"right"' # Right align character -> `▐`.

---@param alignment StripAlignment
---@return table
function M.strip(alignment)
  local char = require("helper.sign").line.NORMAL[alignment or "left"]
  return {
    function()
      return char
    end,
    color = "ModeColorState",
    padding = 0,
  }
end

M.mode = require("plugin.lualine.component.mode")
M.file = require("plugin.lualine.component.file")
M.state = require("plugin.lualine.component.state")
M.git = require("plugin.lualine.component.git")

return M
