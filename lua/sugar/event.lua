local filter_map = {
  ["number"] = "buffer",
  ["string"] = "pattern",
  ["table"] = "pattern",
}
local fn_map = {
  ["function"] = "callback",
  ["string"] = "command",
  ["table"] = "fn_map",
}

local Event = {}

---@class AutoCmdSpec
---@field events string|table
---@field pattern string|table
---@field buffer number
---@field callback function
---@field command string
---@field fn_map table

---Create autocmd specification
---@param events string|table @autocmd-events
---@param filter number|string|table @autocmd-pattern | buffer number of autocmd-buflocal
---@param fn string|function|table @ex-command | callback | or list of both
---@return AutoCmdSpec autocmd
function Event.autocmd(events, filter, fn)
  return {
    events = events,
    [filter_map[type(filter)]] = filter,
    [fn_map[type(fn)]] = fn,
  }
end

---Clear autocmd to avoid duplication
---@param group number
---@param autocmds AutoCmdSpec[]
local function clear(group, autocmds)
  for _, spec in ipairs(autocmds) do
    local autocmd = { group = group, event = spec.events }

    if spec.buffer then
      autocmd.buffer = spec.buffer
    elseif spec.pattern then
      autocmd.pattern = spec.pattern
    end

    vim.api.nvim_clear_autocmds(autocmd)
  end
end

---@param group number
---@param spec AutoCmdSpec
---@return table opts
local function create_opts(group, spec)
  local opts = { group = group }

  for key, value in pairs(spec) do
    if key ~= "events" then
      opts[key] = value
    end
  end

  return opts
end

---@param group string|table @if table, the structure is { group:string, clear:boolean }
---@return number id
local function create_group(group)
  if type(group) == "table" then
    return vim.api.nvim_create_augroup(group[1], { clear = group[2] })
  end

  if type(group) == "string" then
    return vim.api.nvim_create_augroup(group, {})
  end

  return group
end

---Create group of autocommand
---@param group string|table @if table, the structure is { group:string, clear:boolean }
---@param autocmds AutoCmdSpec[]
function Event.augroup(group, autocmds)
  group = create_group(group)
  clear(group, autocmds)

  for _, autocmd in ipairs(autocmds) do
    if autocmd.fn_map then
      -- It means the autocmd have multiple `fn`
      local filter = autocmd.pattern or autocmd.buffer

      local fn_autocmds = {}
      for _, fn in ipairs(autocmd.fn_map) do
        table.insert(fn_autocmds, Event.autocmd(autocmd.events, filter, fn))
      end

      Event.augroup(group, fn_autocmds)
    else
      vim.api.nvim_create_autocmd(autocmd.events, create_opts(group, autocmd))
    end
  end
end

return Event
