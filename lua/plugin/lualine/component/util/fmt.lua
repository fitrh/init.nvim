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

return Fmt
