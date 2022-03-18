local Fmt = {}

---Format output to show `str` if window width >= `width`,
---otherwise, show `fallback`
---
---@param width number #expected width to show the string
---@param str string #string to show
---@param fallback string #string to show if window width less than `width`
---@return string str
function Fmt.show_on_width(width, str, fallback)
  local win_width = vim.api.nvim_win_get_width(0) - #str
  if win_width > (width - 1) then
    return str
  end
  return fallback
end

---Format output to show `str` if screen columns >= `col`,
---otherwise, show `fallback`
---
---@param col number #expected number of screen columns to show the string
---@param str string #string to show
---@param fallback string #string to show if screen columns less than `col`
---@return string str
function Fmt.show_on_column(col, str, fallback)
  local columns = vim.api.nvim_get_option("columns") - #str
  if columns > (col - 1) then
    return str
  end
  return fallback
end

---Wrapper on `show_on_width` and `show_on_column` to return a formatter
---based on `laststatus` value, for `laststatus = 3`, use `show_on_column`
---
---@param min number #minimum value to show the string
---@param str string #string to show
---@param fallback string #string to show if `min` is not met
---@return string str
function Fmt.show_on(min, str, fallback)
  if vim.api.nvim_get_option("laststatus") == 3 then
    return Fmt.show_on_column(min, str, fallback)
  end

  return Fmt.show_on_width(min, str, fallback)
end

return Fmt
