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
---@param args CommandGroup
function Command.group(args)
  args = args or {}

  local prefix = args.prefix or nil
  local opts = args.opts or nil
  local buf = args.buf or nil
  local cmds = args.cmds or {}

  for _, cmd in ipairs(cmds) do
    local name = prefix or ""
    name = ("%s%s"):format(prefix, cmd.name or "")

    opts = opts or cmd.opts
    buf = buf or cmd.buf

    Command.add(name, cmd.cmd, { opts = opts, buf = buf })
  end
end

return Command
