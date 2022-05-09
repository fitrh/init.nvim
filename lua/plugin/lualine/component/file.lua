local condition = require("plugin.lualine.component.util.condition")
local hi = require("sugar.highlight")
local File = {}

File.type = {
  "filetype",
  colored = true,
}

File.icon = {
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
}

---@class FilePathTruncOpts
---@field on number @show number-path after truncated, default: 2
---@field with string @truncation prefix

---@class FilePathOpts
---@field trunc boolean|FilePathTruncOpts
---@field ends string @component suffix

---@param opts FilePathOpts
---@return table component
File.path = function(opts)
  opts = opts or { trunc = false, ends = nil }
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
end

File.name = {
  "filename",
  cond = function()
    return vim.api.nvim_buf_get_name(0) ~= ""
  end,
  color = { gui = "BOLD" },
  path = 0,
  file_status = false,
}

File.location = {
  function()
    local length = #tostring(vim.api.nvim_buf_line_count(0))
    local width = #tostring(vim.api.nvim_buf_get_option(0, "textwidth"))
    return ("%%%sl,%%-%sc"):format(length, width)
  end,
  icon = { "ﰙ", color = { fg = hi.fg("NonText") } },
  cond = condition.not_empty_buf,
}

File.lines = {
  function()
    return vim.api.nvim_buf_line_count(0)
  end,
  icon = "",
  cond = condition.not_empty_buf,
  padding = 0,
}

return File
