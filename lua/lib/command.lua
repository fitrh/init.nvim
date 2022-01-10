local M = {}

function M.add(name, cmd, opts)
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

function M.group(args)
  local opts = args or {}
  local prefix = opts.prefix or nil
  local options = opts.opts or nil
  local buf = opts.buf or nil
  local cmds = opts.cmds or {}
  for _, v in ipairs(cmds) do
    local name = prefix and ("%s%s"):format(prefix, v.name or "") or v.name
    options = options or v.opts
    buf = buf or v.buf
    M.add(name, v.cmd, { options = options, buf = buf })
  end
end

return M
