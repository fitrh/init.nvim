local M = {}

local module = "plugin.lualine.component.util"
M.align = require(("%s.alignment"):format(module))
M.mod = require(("%s.mod"):format(module))
M.fmt = require(("%s.fmt"):format(module))

return M
