local M = {}

local function exec(name, arg)
  local exec = vim.api.nvim_exec
  local filter = arg.filter or nil
  local events = arg.events or nil
  local group = { ("augroup %s"):format(name), "autocmd!" }

  for i, v in ipairs(arg) do
    if type(v) == "table" then
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
