local File = {}

local function when()
  return require("config.plugin.lualine.component.util.condition")
end

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

---@class FilePathOpts
---@field trunc boolean|number @show n-last path part after truncated, default: 2
---@field sep string @separator for each part

---@param opts FilePathOpts
---@return table component
File.path = function(opts)
  opts = opts or { trunc = false, sep = nil }
  return {
    function()
      local i = 1
      local path = vim.fn.expand("%:.:h")
      local path_split = vim.split(path, "/")
      local sep = opts.sep or "/"
      sep = ("%%#StatusLinePathSep#%s%%#StatusLinePath#"):format(sep)

      if opts.trunc then
        opts.trunc = type(opts.trunc) ~= "number" and 2 or opts.trunc
        -- the `- 1` is required because lua is 1-indexed
        i = #path_split > opts.trunc and #path_split - (opts.trunc - 1) or i
      end

      path = table.concat(path_split, (" %s "):format(sep), i)

      if i > 1 and opts.trunc then
        path = ("%s%s"):format(("… %s "):format(sep), path)
      end

      path = ("%s%s"):format(path, (" %s"):format(sep))

      return path
    end,
    color = "StatusLinePath",
    cond = function()
      local path = vim.fn.expand("%:.:h")
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
  icon = { "ﰙ", color = "StatusLineDim" },
  cond = function()
    return when().not_empty_buf()
  end,
}

File.lines = {
  function()
    return vim.api.nvim_buf_line_count(0)
  end,
  icon = { "", color = "StatusLineDim" },
  cond = function()
    return when().not_empty_buf()
  end,
}

return File
