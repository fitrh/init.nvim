local M = {
  function()
    if not vim.b.gitsigns_status or vim.b.gitsigns_status == "" then
      return nil
    end

    local cmd = vim.cmd
    local status = vim.b.gitsigns_status_dict
    local c = require("util.palette")
    local diff = {}
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
      Added = ("%%#DiffAdd# %s"):format(status.added),
      Changed = ("%%#DiffChange# %s"):format(status.changed),
      Removed = ("%%#DiffDelete# %s"):format(status.removed),
    }

    if status.added > 0 then table.insert(diff, state.Added) end
    if status.changed > 0 then table.insert(diff, state.Changed) end
    if status.removed > 0 then table.insert(diff, state.Removed) end

    return table.concat(diff, " ")
  end,
}

return M
