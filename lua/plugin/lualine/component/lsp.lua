local M = {}
local palette = require("plugin.themes.palette")

M.progress = {
  "lsp_progress",
  fmt = function(str)
    local width = vim.api.nvim_win_get_width(0) - #str
    if width < 100 and #str > 16 then
      return ("...%s"):format(str:sub(#str - 16, #str))
    end
    return str
  end,
  color = { fg = palette.blue2, gui = "BOLD" },
  spinner_symbols = { " ", " ", " ", " ", " ", " " },
}

return M
