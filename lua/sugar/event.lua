local FILTER_TYPE = {
  ["number"] = "buffer",
  ["string"] = "pattern",
  ["table"] = "pattern",
}
local ACTION_TYPE = {
  ["function"] = "callback",
  ["string"] = "command",
  ["table"] = "action_list",
}

local Event = {}

---@class AutoCmdSpec
---@field events string|table
---@field pattern string|table
---@field buffer number
---@field callback function
---@field command string
---@field action_list table

---Create autocmd specification
---@param events string|table @autocmd-events
---@param filter number|string|table @autocmd-pattern | buffer number of autocmd-buflocal
---@param action string|function|table @ex-command | callback | or list of both
---@return AutoCmdSpec autocmd
function Event.autocmd(events, filter, action)
  return {
    events = events,
    [FILTER_TYPE[type(filter)]] = filter,
    [ACTION_TYPE[type(action)]] = action,
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
    if autocmd.action_list then
      -- It means the autocmd have multiple `fn`
      local filter = autocmd.pattern or autocmd.buffer

      local autocmd_list = {}
      for _, action in ipairs(autocmd.action_list) do
        table.insert(autocmd_list, Event.autocmd(autocmd.events, filter, action))
      end

      Event.augroup(group, autocmd_list)
    else
      vim.api.nvim_create_autocmd(autocmd.events, create_opts(group, autocmd))
    end
  end
end

return Event
