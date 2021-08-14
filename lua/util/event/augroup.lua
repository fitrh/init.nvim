local M = {}

local function exec(name, args)
  local opts = args or {}
  local exec = vim.api.nvim_exec
  local filter = opts.filter or nil
  local events = opts.events or nil
  local expect = true
  if opts.expect ~= nil then
    expect = opts.expect
  end
  if not expect then
    return nil
  end
  local group = { ("augroup %s"):format(name), "autocmd!" }

  for i, v in ipairs(opts) do
    if type(v) == "table" and (events or v.events) then
      local cmd = ("autocmd %s %s %s"):format(
        v.events or events,
        v.filter or filter or "*",
        v.cmd
      )
      table.insert(group, cmd)
    end
  end
  table.insert(group, "augroup END")
  exec(table.concat(group, "\n"), false)
end

function M.setup(augroups)
  for name, autocmd in pairs(augroups) do
    exec(name, autocmd)
  end
end

return M
