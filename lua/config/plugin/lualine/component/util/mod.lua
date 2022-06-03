---Modify component options
---@param component string|table
---@param opts table
---@return table component #modified component
return function(component, opts)
  if type(component) == "string" then
    component = { component }
  end
  local c = vim.deepcopy(component)

  for key, value in pairs(opts) do
    c[key] = value
  end

  return c
end
