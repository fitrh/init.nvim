local str = require("helper.str")

local M = {}

function M.create(args)
  local opts = args or {}
  local option = opts.options or "-nargs=0"
  local name = str.ufirst(opts.name)
  local cmd = opts.cmd
  cmd = ("command! %s %s %s"):format(option, name, cmd)
  vim.cmd(cmd)
end

return M
