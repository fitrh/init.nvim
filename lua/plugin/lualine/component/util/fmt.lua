local Fmt = {}

---Format output to show `str` when the `min` is met, otherwise, show `fallback`
---
---@param min number #minimum value to show the string
---@param str string #string to show
---@param fallback string|fun(): string #string to show if `min` is not met
---@return string str
function Fmt.show_on(min, str, fallback)
  local strwidth = vim.api.nvim_strwidth(str)
  local allowed_width = vim.api.nvim_win_get_width(0) - strwidth

  if vim.api.nvim_get_option("laststatus") == 3 then
    allowed_width = vim.api.nvim_get_option("columns") - strwidth
  end

  if allowed_width > (min - 1) then
    return str
  end

  if type(fallback) == "function" then
    return fallback()
  end

  return fallback
end

return Fmt
