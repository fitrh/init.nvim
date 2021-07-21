local M = {
  function()
    if not vim.b.gitsigns_status or vim.b.gitsigns_status == "" then
      return nil
    end

    local cmd = vim.cmd
    local status = vim.b.gitsigns_status_dict
    local c = require("util.palette")
    local diff = ""
    local bg = c.bg_statusline

    local highlights = {
      ("DiffAdd guifg=%s guibg=%s"):format(c.gitsigns.add, bg),
      ("DiffChange guifg=%s guibg=%s"):format(c.gitsigns.change, bg),
      ("DiffDelete guifg=%s guibg=%s"):format(c.gitsigns.delete, bg),
    }

    for _, highlight in ipairs(highlights) do
      cmd(("highlight %s"):format(highlight))
    end

    local state = {
      Added = "%#DiffAdd#" .. (" %s "):format(status.added),
      Changed = "%#DiffChange#" .. (" %s "):format(status.changed),
      Removed = "%#DiffDelete#" .. (" %s"):format(status.removed),
    }

    diff = (status.added > 0) and diff .. state.Added or diff
    diff = (status.changed > 0) and diff .. state.Changed or diff
    diff = (status.removed > 0) and diff .. state.Removed or diff

    return diff:gsub('^%s*(.-)%s*$', '%1')
  end,
}

return M
