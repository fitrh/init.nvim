local fmt = require("plugin.lualine.component.util.fmt")

return {
  type = {
    "filetype",
    colored = true,
  },

  icon = {
    active = {
      "filetype",
      colored = true,
      icon_only = true,
    },
    inactive = {
      "filetype",
      colored = false,
      icon_only = true,
    },
  },

  name = {
    "filename",
    color = { gui = "BOLD" },
    fmt = function(str)
      return fmt.show_on_width(80, str, "%t")
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
  },

  lines = {
    function()
      return vim.api.nvim_buf_line_count(0)
    end,
    icon = "",
    padding = 0,
  },
}
