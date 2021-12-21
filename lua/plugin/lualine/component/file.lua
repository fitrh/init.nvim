return {
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
    color = "LualineComponentLines",
    padding = 0,
  },
}
