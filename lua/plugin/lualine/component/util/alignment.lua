---@param component table
---@param padding table
---@return table
local function alignment(component, padding)
  component.padding = padding
  return component
end

local M = {}

---component.padding = { left = 0, right = 1 }
---@param component table
---@return table
function M.left(component)
  return alignment(component, { left = 0, right = 1 })
end

---component.padding = { left = 1, right = 0 }
---@param component table
---@return table
function M.right(component)
  return alignment(component, { left = 1, right = 0 })
end

---component.padding = 0
---@param component table
---@return table
function M.no(component)
  return alignment(component, 0)
end

return M
