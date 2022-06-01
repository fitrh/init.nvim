local TabLine = {}

local function separator(sel)
  return table.concat({ sel and "%#TabLineSepSel#" or "%#TabLineSep#", "▏" })
end

local function title(tabpage, bufnr, sel)
  local id = vim.api.nvim_tabpage_get_number(tabpage)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local fname = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "□"

  if sel then
    return table.concat({ "%#TabLineSel#", (" %s "):format(fname) })
  end

  return table.concat({ "%#TabLine#", ("%d:%s"):format(id, fname) })
end

local function modified(bufnr, sel)
  if vim.api.nvim_buf_get_name(bufnr) == "" then
    return ""
  end

  if not vim.api.nvim_buf_get_option(bufnr, "modified") then
    return ""
  end

  return table.concat({
    not sel and " " or "",
    sel and "%#TabLineModifiedSel#" or "%#TabLineModified#",
    require("const.ICON").STATE.MODIFIED,
  })
end

function TabLine.draw()
  local tabline = {}
  local api = vim.api
  local insert = table.insert

  for _, tabpage in ipairs(api.nvim_list_tabpages()) do
    local sel = tabpage == api.nvim_get_current_tabpage()
    local bufnr = api.nvim_win_get_buf(api.nvim_tabpage_get_win(tabpage))

    local label = { ("%%%dT"):format(api.nvim_tabpage_get_number(tabpage)) }
    insert(label, separator(sel))
    insert(label, title(tabpage, bufnr, sel))
    insert(label, modified(bufnr, sel))
    insert(label, " %#TabLineFill#")

    insert(tabline, table.concat(label))
  end

  return table.concat(tabline)
end

return TabLine
