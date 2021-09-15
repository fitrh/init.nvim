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

function M.group(args)
  local opts = args or {}
  local prefix = opts.prefix or nil
  local option = opts.option or nil
  local create = opts.create or {}
  for _, v in ipairs(create) do
    local name = prefix
        and ("%s%s"):format(
          str.ufirst(prefix),
          str.ufirst(v.name or "")
        )
      or str.ufirst(v.name)
    option = option or v.option
    M.create({ option = option, name = name, cmd = v.cmd })
  end
end

return M
