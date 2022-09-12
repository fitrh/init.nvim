local function get_path(win, buf)
  local strwidth = vim.api.nvim_strwidth
  local sep = " / "
  local file_path = vim.fn.fnamemodify(buf, ":.") -- get the relative path with the filename
  file_path = vim.split(file_path, "/")

  if #file_path == 1 then
    return false
  end

  local half_win_width = math.ceil(vim.api.nvim_win_get_width(win) / 2)
  local file_path_width = strwidth(table.concat(file_path, sep))
  local path = table.concat(file_path, sep, 1, #file_path - 1) -- formatted relative path, but omit the filename

  if file_path_width > half_win_width then
    local i = (file_path_width - half_win_width) + 7
    local trunc_char = (path:sub(i, i) == " ") and "…" or "… "
    path = ("%s%s"):format(trunc_char, path:sub(i))
  end

  return ("%s%s"):format(path, sep)
end

return function(props)
  local result = {
    {
      (" %d "):format(vim.api.nvim_win_get_number(props.win)),
      group = "InclineWinNr",
    },
    " ",
  }
  local buf = props.buf
  local opt = vim.api.nvim_buf_get_option

  local bufname = vim.api.nvim_buf_get_name(buf)
  local path = get_path(props.win, bufname)
  if path then
    result[#result + 1] = path
  end

  local const = require("const.ICON")
  local ICON = {
    RO = ("%s "):format(const.STATE.READONLY),
    MO = ("%s "):format(const.STATE.MODIFIED),
  }

  if opt(buf, "readonly") or not opt(buf, "modifiable") then
    result[#result + 1] = { ICON.RO, group = "StatusLineRO" }
  end

  if opt(buf, "modified") then
    result[#result + 1] = { ICON.MO, group = "StatusLineModified" }
  end

  local filename = vim.fn.fnamemodify(bufname, ":t")
  filename = path and { filename, gui = "bold" } or filename
  result[#result + 1] = filename

  return { result, " " }
end
