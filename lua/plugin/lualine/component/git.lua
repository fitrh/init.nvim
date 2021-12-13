local palette = require("helper.palette")

return {
  diff = {
    "diff",
    padding = { left = 1, right = 0 },
    diff_color = {
      added = { fg = palette.gitsigns.add },
      modified = { fg = palette.gitsigns.change },
      removed = { fg = palette.gitsigns.delete },
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
  },

  branch = {
    "branch",
    icon = "",
    color = { fg = palette.purple, gui = "BOLD" },
  },
}
