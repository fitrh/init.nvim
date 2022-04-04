local Condition = {}

---Determine whether the minimum required space is available
---@param min number #minimum space required
---@return boolean
function Condition.space_at_least(min)
  if vim.api.nvim_get_option("laststatus") == 3 then
    return vim.api.nvim_get_option("columns") >= min
  end

  return vim.api.nvim_win_get_width(0) >= min
end

---Determine whether the current buffer is not in a modified state
---@return boolean
function Condition.not_modified()
  return not vim.api.nvim_buf_get_option(0, "modified")
end

---Determine whether the current buffer sets the `filetype` option
---@return boolean
function Condition.not_empty_ft()
  return vim.api.nvim_buf_get_option(0, "filetype") ~= ""
end

---Wrapping `not_empty_ft()` and add a condition to determine
---if the buffer has more than one line
---@return boolean
function Condition.not_empty_buf()
  return Condition.not_empty_ft() and vim.api.nvim_buf_line_count(0) > 1
end

return Condition
