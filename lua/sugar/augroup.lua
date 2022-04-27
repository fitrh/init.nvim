---Pick one attributes for `opts` that cannot be used simultaneously
---@param opts table #`opts` for `nvim_create_autocmd`
---@param spec table #autocommand specification
---@param attr table #attributes to choose
---@return table
local function pick(opts, spec, attr)
  if spec[attr[1]] and not spec[attr[2]] then
    opts[attr[1]] = spec[attr[1]]
    return opts
  end

  if spec[attr[2]] and not spec[attr[1]] then
    opts[attr[2]] = spec[attr[2]]
    return opts
  end

  return opts
end

---@class AuCmd
---@field events string|table
---@field pattern string|table
---@field buffer boolean|number
---@field callback function
---@field command string
---@field desc string
---@field once boolean @defaults to false
---@field nested boolean @defaults to false

---Create autocommands group, wrapper of:
--- - `nvim_create_augroup`
--- - `nvim_create_autocmd`
---@param group string #Group name
---@param autocmds AuCmd|AuCmd[] #`autocmd` or list of `autocmd`
return function(group, autocmds)
  local api = {
    augroup = vim.api.nvim_create_augroup,
    autocmd = vim.api.nvim_create_autocmd,
  }

  group = api.augroup(group, {})

  -- if there is only one autocommand
  if autocmds.callback or autocmds.command then
    local opts = { group = group }
    opts = pick(opts, autocmds, { "callback", "command" })
    opts = pick(opts, autocmds, { "buffer", "pattern" })
    api.autocmd(autocmds[1], opts)
    return
  end

  local events = nil
  for _, autocmd in ipairs(autocmds) do
    local opts = { group = group }

    if type(autocmd) == "string" then
      -- StringEvent, { autocommand }, { autocommand }, ...
      -- This pattern means every `autocommand` sets its `events` to StringEvent
      events = autocmd
    else
      -- { events = StringEvent, autocommand_spec }
      -- This pattern means use `events` key if present
      -- or use first indexed element as events,
      -- which means following pattern applied
      -- { StringEvent, autocommand_spec }
      -- If no element indexed, use previous events
      events = autocmd.events or autocmd[1] or events
    end

    if type(autocmd) == "table" then
      opts = pick(opts, autocmd, { "callback", "command" })
      opts = pick(opts, autocmd, { "buffer", "pattern" })
      api.autocmd(events, opts)
    end
  end
end
