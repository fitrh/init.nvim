local M = {}

---@param width? number @default = 1
---@return table component
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
---| '"left"'
---| '"right"'

---@param alignment? StripAlignment @default "left"
---@return table component
function M.strip(alignment)
  local char = require("const.LINE_CHAR").THIN[alignment or "left"]
  return {
    function()
      return char
    end,
    padding = 0,
  }
end

local module = "plugin.lualine.component"
M.mode = require(("%s.mode"):format(module))
M.file = require(("%s.file"):format(module))
M.state = require(("%s.state"):format(module))
M.git = require(("%s.git"):format(module))
M.diagnostic = require(("%s.diagnostic"):format(module))

return M
