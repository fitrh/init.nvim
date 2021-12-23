local M = {}

function M.fg(group_name)
  local hl = vim.api.nvim_get_hl_by_name(group_name, true)
  return hl.foreground and ("#%06x"):format(hl.foreground) or "NONE"
end

function M.bg(group_name)
  local hl = vim.api.nvim_get_hl_by_name(group_name, true)
  return hl.background and ("#%06x"):format(hl.background) or "NONE"
end

function M.set(group_name, gui, tui)
  local fg = gui.fg or "NONE"
  local bg = gui.bg or "NONE"

  local hl_def = ("guifg=%s guibg=%s"):format(fg, bg)
  if gui.sp then
    hl_def = hl_def .. (" guisp=%s"):format(gui.sp)
  end
  if gui.style then
    hl_def = hl_def .. (" gui=%s"):format(gui.style)
  end
  if tui then
    hl_def = hl_def
      .. ("ctermfg=%s ctermbg=%s"):format(tui.fg or "NONE", tui.bg or "NONE")
  end

  local command = ("highlight %s %s"):format(group_name, hl_def)
  vim.api.nvim_command(command)
end

return M
