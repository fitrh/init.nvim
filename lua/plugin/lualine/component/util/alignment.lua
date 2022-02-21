---@param component string|table
---@param padding table
---@return table component
local function alignment(component, padding)
  if type(component) == "string" then
    component = { component }
  end
  component.padding = padding
  return component
end

local Align = {}

---component.padding = { left = 0, right = 1 }
---@param component string|table
---@return table component
function Align.left(component)
  return alignment(component, { left = 0, right = 1 })
end

---component.padding = { left = 1, right = 0 }
---@param component string|table
---@return table component
function Align.right(component)
  return alignment(component, { left = 1, right = 0 })
end

---component.padding = 0
---@param component string|table
---@return table component
function Align.no(component)
  return alignment(component, 0)
end

return Align
