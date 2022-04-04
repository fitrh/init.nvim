local fmt = require("plugin.lualine.component.util.fmt")
local condition = require("plugin.lualine.component.util.condition")

return {
  type = {
    "filetype",
    colored = true,
  },

  icon = {
    "filetype",
    colored = true,
    icon_only = true,
  },

  name = {
    "filename",
    cond = function()
      return vim.fn.expand("%:t") ~= ""
    end,
    color = { gui = "BOLD" },
    fmt = function(str)
      return fmt.show_on(80, str, "%t")
    end,
    path = 1, -- relative path
    file_status = false,
  },

  location = {
    function()
      local length = #tostring(vim.api.nvim_buf_line_count(0))
      local width = #tostring(vim.api.nvim_buf_get_option(0, "textwidth"))
      return ("%%%sl,%%-%sc"):format(length, width)
    end,
    icon = "ﰙ",
    cond = condition.not_empty_ft,
  },

  lines = {
    function()
      return vim.api.nvim_buf_line_count(0)
    end,
    icon = "",
    cond = condition.not_empty_ft,
    padding = 0,
  },
}
