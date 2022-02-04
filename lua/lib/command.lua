local Command = {}

---Create user command
---Use `nvim_add_user_command` or `nvim_buf_add_user_command`
---
---@param name string #command name, UpperCamelCase
---@param cmd string|function #command string or lua function
---@param opts table #optional command attributes, see `:h command-attributes`
function Command.add(name, cmd, opts)
  opts = opts or {}
  local options = opts.opts or { nargs = 0 }
  local buf = opts.buf or false

  if buf then
    local nr = type(buf) == "number" and buf or 0
    vim.api.nvim_buf_add_user_command(nr, name, cmd, options)
  else
    vim.api.nvim_add_user_command(name, cmd, options)
  end
end

---@class CommandGroup
---@field prefix string
---@field opts table
---@field buf number|boolean
---@field cmds UserCommand
---
---@class UserCommand
---@field name string
---@field cmd string|function
---@field opts table
---
---Create group of user command
---
---@param args UserCommand
function Command.group(args)
  local opts = args or {}
  local prefix = opts.prefix or nil
  local options = opts.opts or nil
  local buf = opts.buf or nil
  local cmds = opts.cmds or {}
  for _, v in ipairs(cmds) do
    local name = prefix and ("%s%s"):format(prefix, v.name or "") or v.name
    options = options or v.opts
    buf = buf or v.buf
    Command.add(name, v.cmd, { options = options, buf = buf })
  end
end

return Command
