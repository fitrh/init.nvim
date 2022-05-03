local config = {}

local function get_path(win, buf)
  local strwidth = vim.api.nvim_strwidth
  local sep = " / "
  local file_path = vim.fn.fnamemodify(buf, ":.") -- get the relative path with the filename
  file_path = vim.split(file_path, "/")

  if #file_path == 1 then
    return ""
  end

  local half_win_width = math.ceil(vim.api.nvim_win_get_width(win) / 2)
  local file_path_width = strwidth(table.concat(file_path, sep))
  local path = table.concat(file_path, sep, 1, #file_path - 1) -- formatted relative path, but omit the filename

  if file_path_width > half_win_width then
    local i = file_path_width - half_win_width
    local trunc_char = (path:sub(i, i) == " ") and "…" or "… "

    path = ("%s%s"):format(trunc_char, path:sub(i))
  end

  return ("%s%s"):format(path, sep)
end

config.render = function(props)
  local render_result = {}
  local buf = props.buf
  local opt = vim.api.nvim_buf_get_option

  local bufname = vim.api.nvim_buf_get_name(buf)
  if bufname == "" then
    return "[No Name]"
  end

  local path = get_path(props.win, bufname)
  table.insert(render_result, path)

  if opt(buf, "readonly") or not opt(buf, "modifiable") then
    table.insert(render_result, { " ", group = "StatusLineRO" })
  end

  if opt(buf, "modified") then
    table.insert(render_result, { " ", group = "StatusLineModified" })
  end

  local filename = vim.fn.fnamemodify(bufname, ":t")
  filename = path ~= "" and { filename, gui = "bold" } or filename
  table.insert(render_result, filename)

  return render_result
end

config.window = {
  options = {
    winblend = vim.api.nvim_get_option("pumblend"),
  },
}

config.hide = {
  focused_win = true,
}

require("incline").setup(config)
