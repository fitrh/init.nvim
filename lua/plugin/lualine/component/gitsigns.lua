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

    local hl_groups = {
      ("Added guifg=%s guibg=%s"):format(c.gitsigns.add, bg),
      ("Changed guifg=%s guibg=%s"):format(c.gitsigns.change, bg),
      ("Removed guifg=%s guibg=%s"):format(c.gitsigns.delete, bg),
    }

    for _, group in ipairs(hl_groups) do
      cmd(("highlight %s"):format(group))
    end

    local state = {
      Added = ("%%#Added# %s"):format(status.added),
      Changed = ("%%#Changed# %s"):format(status.changed),
      Removed = ("%%#Removed# %s"):format(status.removed),
    }

    if status.added > 0 then table.insert(diff, state.Added) end
    if status.changed > 0 then table.insert(diff, state.Changed) end
    if status.removed > 0 then table.insert(diff, state.Removed) end

    return table.concat(diff, " ")
  end,
}

return M
