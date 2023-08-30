local Keymap = {}

---@class KeymapModeSetter
---@field normal fun(map: KeymapDef): KeymapDef Map in normal mode(`n`)
---@field insert fun(map: KeymapDef): KeymapDef Map in insert mode(`i`)
---@field visual fun(map: KeymapDef): KeymapDef Map in visual mode(`x`)
---@field select fun(map: KeymapDef): KeymapDef Map in select mode(`s`)
---@field vselect fun(map: KeymapDef): KeymapDef Map in visual-select mode(`v`)
---@field opending fun(map: KeymapDef): KeymapDef Map in operator-pending mode(`o`)
---@field cmd fun(map: KeymapDef): KeymapDef Map command-line mode(`c`)
---@field icmd fun(map: KeymapDef): KeymapDef Map insert-commandline mode(`!`)
---@field terminal fun(map: KeymapDef): KeymapDef Map terminal mode(`t`)
Keymap.mode = {}

---@class KeymapModifier
---@field nop fun(map: KeymapDef): KeymapDef Disable the map
---@field ex fun(excmd: string): string Surround the excmd with <Cmd> and <CR>
---@field plug fun(excmd: string): string Prepend the excmd with <Plug>
---@field leader fun(key: string): string Prepend the key with <Leader>
Keymap.modifier = {}

---@class KeymapDef
---@field mode string|table
---@field lhs string
---@field rhs string|function
---@field opts? table

---@class KeymapArgs
---@field buffer? boolean|number
---@field nowait? boolean
---@field silent? boolean
---@field script? boolean
---@field expr? boolean
---@field unique? boolean
---@field replace_keycodes? boolean @default true
---@field remap? boolean @default false

---Create keymap definition
---@param key string
---@param fn? string|function
---@param opts? KeymapArgs
---@return KeymapDef definition
function Keymap.map(key, fn, opts)
  local keymap = {
    mode = {},
    lhs = key,
    rhs = fn or function() end,
    opts = opts,
  }
  return keymap
end

---`vim.keymap.set` wrapper
---@param keymap KeymapDef
---@param opts? KeymapArgs
local function set(keymap, opts)
  keymap.mode = next(keymap.mode) and keymap.mode or ""
  keymap.opts = keymap.opts or opts or {}
  vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, keymap.opts)
end

---Bind @keymaps using `vim.keymap.set` API
---@param keymaps KeymapDef|KeymapDef[]
---@param opts? KeymapArgs @global opts
function Keymap.bind(keymaps, opts)
  if not next(keymaps) then
    return
  end

  if type(next(keymaps)) == "number" then
    for _, keymap in ipairs(keymaps) do
      set(keymap, opts)
    end
  else
    set(keymaps)
  end
end

function Keymap.modifier.ex(fn)
  return ("<Cmd>%s<CR>"):format(fn)
end

function Keymap.modifier.plug(fn)
  return ("<Plug>%s"):format(fn)
end

function Keymap.modifier.leader(lhs)
  return ("<Leader>%s"):format(lhs)
end

function Keymap.modifier.nop(map)
  map.rhs = ""
  return map
end

---Set @map.mode[@mode]
---@param mode string
---@param map KeymapDef
---@return KeymapDef
local function mapmode(mode, map)
  table.insert(map.mode, mode)
  return map
end

function Keymap.mode.normal(map)
  return mapmode("n", map)
end

function Keymap.mode.insert(map)
  return mapmode("i", map)
end

function Keymap.mode.vselect(map)
  return mapmode("v", map)
end

function Keymap.mode.select(map)
  return mapmode("s", map)
end

function Keymap.mode.visual(map)
  return mapmode("x", map)
end

function Keymap.mode.opending(map)
  return mapmode("o", map)
end

function Keymap.mode.cmd(map)
  return mapmode("c", map)
end

function Keymap.mode.icmd(map)
  return mapmode("!", map)
end

function Keymap.mode.terminal(map)
  return mapmode("t", map)
end

return Keymap
