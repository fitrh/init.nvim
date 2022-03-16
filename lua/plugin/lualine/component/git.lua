local palette = require("plugin.themes.palette")
local hi = require("lib.highlight")

return {
  diff = {
    "diff",
    cond = function()
      return vim.api.nvim_win_get_width(0) > 69
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
  },

  branch = {
    "branch",
    icon = "",
    cond = function()
      return vim.api.nvim_win_get_width(0) > 49
    end,
    color = { fg = palette.magenta.secondary, gui = "BOLD" },
  },
}
