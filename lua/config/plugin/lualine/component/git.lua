local Git = {}

local function when()
  return require("config.plugin.lualine.component.util.condition")
end

Git.diff = {
  "diff",
  cond = function()
    return when().space_at_least(70)
  end,
  diff_color = {
    added = "StatusLineGitDiffAdd",
    modified = "StatusLineGitDiffChange",
    removed = "StatusLineGitDiffDelete",
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
    return when().space_at_least(70)
  end,
  color = "StatusLineGitBranch",
}

return Git
