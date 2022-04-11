local Command = {}

---@class CmdAttrs
---@field nargs number|string
---@field complete string|function
---@field range boolean|number|string
---@field count number
---@field addr string|function
---@field bang boolean
---@field bar boolean
---@field register string
---@field buffer boolean
---@field keepscript boolean
---@field desc string
---@field force boolean @default true

---@class CmdOpts
---@field buf boolean|number
---@field opts CmdAttrs

---Create user command
---Use `nvim_add_user_command` or `nvim_buf_add_user_command`
---@param name string #command name, UpperCamelCase
---@param cmd string|fun(opts?: table) #command string or lua function
---@param opts CmdOpts #optional command attributes, see `:h command-attributes`
function Command.add(name, cmd, opts)
  opts = opts or {}
  local options = opts.opts or { nargs = 0 }
  local buf = opts.buf or false

  if buf then
    local nr = type(buf) == "number" and buf or 0
    vim.api.nvim_buf_create_user_command(nr, name, cmd, options)
  else
    vim.api.nvim_create_user_command(name, cmd, options)
  end
end

---@class CommandGroup
---@field prefix string
---@field opts table
---@field buf number|boolean
---@field cmds UserCommand[]

---@class UserCommand
---@field name string
---@field cmd string|function
---@field opts CmdOpts

---Create group of user command
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

    opts = cmd.opts or opts or nil
    buf = cmd.buf or buf or false

    Command.add(name, cmd.cmd, { opts = opts, buf = buf })
  end
end

return Command
