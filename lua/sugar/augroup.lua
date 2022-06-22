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

---Create autocmd specification
---@param events string|table @autocmd-events
---@param filter number|string|table @autocmd-pattern | buffer number of autocmd-buflocal
---@param action string|function|table @ex-command | callback | or list of both
local function autocmd(events, filter, action, group)
  vim.api.nvim_clear_autocmds({
    event = events,
    [FILTER_TYPE[type(filter)]] = filter,
    group = group,
  })

  if type(action) == "table" then
    for _, each in ipairs(action) do
      vim.api.nvim_create_autocmd(events, {
        group = group,
        [FILTER_TYPE[type(filter)]] = filter,
        [ACTION_TYPE[type(each)]] = each,
      })
    end
    return
  end

  vim.api.nvim_create_autocmd(events, {
    group = group,
    [FILTER_TYPE[type(filter)]] = filter,
    [ACTION_TYPE[type(action)]] = action,
  })
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

---@alias AuCallback fun(events:string|table, filter:number|string|table, action:string|function)

---Create group of autocommand
---@param name string|table @if table, the structure is { group:string, clear:boolean }
---@param callback fun(au:AuCallback)
return function(name, callback)
  local group = create_group(name)
  callback(function(events, filter, action)
    return autocmd(events, filter, action, group)
  end)
end
