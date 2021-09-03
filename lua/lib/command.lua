local str = require("helper.str")

local M = {}

function M.create(args)
  local opts = args or {}
  local redefine = opts.redefine and "command!" or "command"
  local option = opts.options or "-nargs=0"
  local name = str.ufirst(opts.name)
  local cmd = opts.cmd
  cmd = ("%s %s %s %s"):format(redefine, option, name, cmd)
  vim.cmd(cmd)
end

return M
