---@param component table
---@param padding table
---@return table
local function alignment(component, padding)
  component.padding = padding
  return component
end

local M = {}

---@param component table
---@return table
function M.left(component)
  return alignment(component, { left = 0, right = 1 })
end

---@param component table
---@return table
function M.right(component)
  return alignment(component, { left = 1, right = 0 })
end

---@param component table
---@return table
function M.no(component)
  return alignment(component, 0)
end

return M
