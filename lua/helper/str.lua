local M = {}

function M.ufirst(str)
  return str:gsub("^%l", string.upper)
end

return M
