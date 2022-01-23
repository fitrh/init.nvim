local palette = require("plugin.themes.palette")

return {
  diff = {
    "diff",
    cond = function()
      return vim.api.nvim_win_get_width(0) > 69
    end,
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
    cond = function()
      return vim.api.nvim_win_get_width(0) > 49
    end,
    color = { fg = palette.purple, gui = "BOLD" },
  },
}
