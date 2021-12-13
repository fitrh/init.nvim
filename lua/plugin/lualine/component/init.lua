local palette = require("helper.palette")

local M = {}

function M.spacer(width)
  width = width or 1
  return {
    function()
      return string.rep(" ", width)
    end,
    padding = 0,
  }
end

M.mode = require("plugin.lualine.component.mode")

M.file = {
  type = {
    "filetype",
    colored = true,
  },

  icon = {
    "filetype",
    padding = { left = 0, right = 1 },
    colored = true,
    icon_only = true,
  },

  name = {
    "filename",
    color = { gui = "BOLD" },
    padding = { left = 0, right = 1 },
    path = 1, -- relative path
    file_status = false,
  },

  location = {
    function()
      local length = #tostring(vim.fn.line("$"))
      local width = #tostring(vim.api.nvim_buf_get_option(0, "textwidth"))
      return ("%%%sl,%%-%sc"):format(length, width)
    end,
    icon = "ﰙ",
  },

  lines = {
    function()
      return tostring(vim.fn.line("$"))
    end,
    icon = "", -- the above function must return string to make icon work
    color = { fg = palette.blue },
    padding = 0,
  },
}

M.state = {
  modified = {
    function()
      return ""
    end, -- "ﴖ"
    cond = function()
      return vim.bo.modified
    end,
    color = { fg = palette.red_br_2 }, -- palette.blue5
    padding = 0,
  },

  readonly = {
    function()
      return "" -- ""
    end,
    cond = function()
      return vim.bo.readonly or not vim.bo.modifiable
    end,
    color = { fg = palette.red1 },
    padding = { left = 0, right = 1 },
  },
}

M.git = {
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

return M
