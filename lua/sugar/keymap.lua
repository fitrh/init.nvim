local Keymap = {}
Keymap.mode = {}
Keymap.modifier = {}

---@class KeymapDef
---@field mode string|table
---@field lhs string
---@field rhs string|function
---@field opts table

---@class KeymapArgs
---@field buffer boolean|number
---@field nowait boolean
---@field silent boolean
---@field script boolean
---@field expr boolean
---@field unique boolean
---@field replace_keycodes boolean @default true
---@field remap boolean @default false

---Create keymap definition
---@param key string
---@param fn string|function
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
---@param opts KeymapArgs
local function set(keymap, opts)
  keymap.mode = next(keymap.mode) and keymap.mode or ""
  keymap.opts = keymap.opts or opts or {}
  vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, keymap.opts)
end

---Bind @keymaps using `vim.keymap.set` API
---
---@param keymaps KeymapDef|KeymapDef[]
---@param opts KeymapArgs @global opts
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

---Function modifier to wrap an ex/user command with `<Cmd>fn<CR>`
---@param fn string @ex command
---@return string
function Keymap.modifier.ex(fn)
  return ("<Cmd>%s<CR>"):format(fn)
end

---Function modifier to prepend `<Plug>` to `fn`
---@param fn string @ex command
---@return string
function Keymap.modifier.plug(fn)
  return ("<Plug>%s"):format(fn)
end

---Key modifier to prepend `<Leader>` to KeymapDef.lhs
---@param lhs string @KeymapDef.lhs
---@return string
function Keymap.modifier.leader(lhs)
  return ("<Leader>%s"):format(lhs)
end

---Keymap modifier to disable a keymap
---@param map KeymapDef
---@return KeymapDef definition
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

---Assign normal mode(`n`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.normal(map)
  return mapmode("n", map)
end

---Assign insert mode(`i`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.insert(map)
  return mapmode("i", map)
end

---Assign visual-select mode(`v`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.vselect(map)
  return mapmode("v", map)
end

---Assign select mode(`s`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.select(map)
  return mapmode("s", map)
end

---Assign visual mode(`x`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.visual(map)
  return mapmode("x", map)
end

---Assign operator-pending mode(`o`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.opending(map)
  return mapmode("o", map)
end

---Assign command-line mode(`c`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.cmd(map)
  return mapmode("c", map)
end

---Assign insert-commandline mode(`!`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.icmd(map)
  return mapmode("!", map)
end

---Assign terminal mode(`t`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.terminal(map)
  return mapmode("t", map)
end

return Keymap
