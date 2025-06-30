-- TODO: Replace "%=" with spaces repeated programmatically based on available
-- space, formula: (('columns' / #vim.api.nvim_list_tabpages()) - #title) / 2
local TabLine = {}

local function separator(sel)
  return table.concat({ sel and "%#TabLineSepSel#" or "%#TabLineSep#", "▏" })
end

local function title(tabpage, bufnr, sel)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local text = (bufname ~= "") and vim.fn.fnamemodify(bufname, ":t") -- FIXME: vim.fn.fnamemodify may returns empty string
    or (filetype ~= "") and filetype
    or "[No Name]"

  if sel then
    return table.concat({ "%#TabLineSel#", ("%s"):format(text) })
  end

  local id = vim.api.nvim_tabpage_get_number(tabpage)
  return table.concat({ "%#TabLine#", ("%d:%s"):format(id, text) })
end

local function modified(bufnr, sel)
  if vim.api.nvim_buf_get_name(bufnr) == "" then
    return " "
  end

  if not vim.api.nvim_buf_get_option(bufnr, "modified") then
    return " "
  end

  return table.concat({
    sel and "%#TabLineModifiedSel#" or "%#TabLineModified#",
    require("const.ICON").STATE.MODIFIED,
  })
end

function TabLine.draw() -- TODO: return as function, remove `TabLine` table
  local tabline = {}
  local api = vim.api
  local insert = table.insert -- TODO: Remove, use `t[#t + 1] = val` syntax

  for _, tabpage in ipairs(api.nvim_list_tabpages()) do
    local sel = tabpage == api.nvim_get_current_tabpage()
    local bufnr = api.nvim_win_get_buf(api.nvim_tabpage_get_win(tabpage))

    local label = { "%" .. tabpage .. "T" }
    -- TODO: Move spaces management here, easier to fix width-shift
    insert(label, separator(sel))
    insert(label, "%=")
    if sel then
      insert(label, "  ")
    end
    insert(label, modified(bufnr, sel))
    insert(label, " ")
    insert(label, title(tabpage, bufnr, sel))
    insert(label, "%=")
    insert(label, " %#TabLineFill#%T") -- %T: end label

    insert(tabline, table.concat(label))
  end

  return table.concat(tabline)
end

return TabLine
