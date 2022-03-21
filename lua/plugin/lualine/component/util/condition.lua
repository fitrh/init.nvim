local Condition = {}

---Determine whether the minimum required space is available
---
---@param min number #minimum space required
---@return boolean
function Condition.space_at_least(min)
  if vim.api.nvim_get_option("laststatus") == 3 then
    return vim.api.nvim_get_option("columns") >= min
  end

  return vim.api.nvim_win_get_width(0) >= min
end

return Condition
