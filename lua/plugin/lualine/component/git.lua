local hi = require("sugar.highlight")
local condition = require("plugin.lualine.component.util.condition")
local Git = {}

Git.diff = {
  "diff",
  cond = function()
    return condition.space_at_least(70)
  end,
  diff_color = {
    added = { fg = hi.fg("GitSignsAdd", { "diffAdded" }) },
    modified = { fg = hi.fg("GitSignsChange", { "diffChanged" }) },
    removed = { fg = hi.fg("GitSignsDelete", { "diffRemoved" }) },
  },
  symbols = { added = " ", modified = " ", removed = " " },
  source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end,
}

Git.branch = {
  "branch",
  icon = "",
  cond = function()
    return condition.space_at_least(50)
  end,
  color = { fg = hi.fg("StatusLineGitBranch", { "StatusLine" }) },
}

return Git
