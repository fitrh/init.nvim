local M = {
  function()
    if not vim.b.gitsigns_status or vim.b.gitsigns_status == "" then return nil end

    local diff = ""
    local status = vim.b.gitsigns_status_dict
    local symbols = {
      added = "",
      changed = "",
      removed = ""
    }

    -- TODO: set color
    diff = (status.added and status.added > 0) and diff .. ("%s %s "):format(symbols.added, status.added) or diff
    diff = (status.changed and status.changed > 0) and diff .. ("%s %s "):format(symbols.changed, status.changed) or diff
    diff = (status.removed and status.removed > 0) and diff .. ("%s %s"):format(symbols.removed, status.removed) or diff

    return diff:gsub('^%s*(.-)%s*$', '%1')
  end,
}

return M
