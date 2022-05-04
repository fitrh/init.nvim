local fmt = require("plugin.lualine.component.util.fmt")
local condition = require("plugin.lualine.component.util.condition")

return {
  type = {
    "filetype",
    colored = true,
  },

  icon = {
    "filetype",
    fmt = function(str)
      if
        vim.api.nvim_buf_get_option(0, "filetype") == ""
        and vim.api.nvim_buf_get_name(0) ~= ""
      then
        return "default"
      end

      return str
    end,
    colored = true,
    icon_only = true,
  },

  path = function(opts)
    opts = opts or { trunc = false, start = nil, ends = nil }
    return {
      function()
        local i = 1
        local path = vim.fn.expand("%:h")
        local path_split = vim.split(path, "/")

        if opts.trunc then
          local on = opts.trunc.on and opts.trunc.on or 2
          i = #path_split > on and #path_split - (on - 1) or i
        end

        path = table.concat(path_split, " / ", i)

        if i > 1 and opts.trunc.with then
          path = ("%s%s"):format(opts.trunc.with, path)
        end

        if opts.ends then
          path = ("%s%s"):format(path, opts.ends)
        end

        return path
      end,
      color = "StatusLinePath",
      cond = function()
        local path = vim.fn.expand("%:h")
        return path ~= "" and path ~= "."
      end,
    }
  end,

  name = {
    "filename",
    cond = function()
      return vim.api.nvim_buf_get_name(0) ~= ""
    end,
    color = { gui = "BOLD" },
    fmt = function(str)
      return fmt.show_on(80, str, "%t")
    end,
    path = 0, -- relative path
    file_status = false,
  },

  location = {
    function()
      local length = #tostring(vim.api.nvim_buf_line_count(0))
      local width = #tostring(vim.api.nvim_buf_get_option(0, "textwidth"))
      return ("%%%sl,%%-%sc"):format(length, width)
    end,
    icon = "ﰙ",
    cond = condition.not_empty_buf,
  },

  lines = {
    function()
      return vim.api.nvim_buf_line_count(0)
    end,
    icon = "",
    cond = condition.not_empty_buf,
    padding = 0,
  },
}
