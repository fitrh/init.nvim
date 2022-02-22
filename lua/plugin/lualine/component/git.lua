local palette = require("plugin.themes.palette")

return {
  diff = {
    "diff",
    cond = function()
      return vim.api.nvim_win_get_width(0) > 69
    end,
    diff_color = {
      added = { fg = palette and palette.diff.added or "#72BC11" },
      modified = { fg = palette and palette.diff.changed or "#1155AA" },
      removed = { fg = palette and palette.diff.deleted or "#A01B2E" },
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
    color = {
      fg = palette and palette.magenta.secondary or "#A133E1",
      gui = "BOLD",
    },
  },
}
