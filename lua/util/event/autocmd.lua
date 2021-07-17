local M = {}

local function exec(args)
  local opts = args or {}
  local event = opts.event
  local filter = opts.filter or "*"
  local cmd = opts.cmd
  local command = vim.api.nvim_command
  command(string.format("autocmd %s %s %s", event, filter, cmd))
end

function M.setup(args)
  local autocommands = args or {}
  for e, v in pairs(autocommands) do
    exec({
      event = e,
      filter = v.filter,
      cmd = v.cmd,
    })
  end
end

return M
