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
  local modes = ""

  if type(keymap.mode) == "table" and next(keymap.mode) then
    modes = {}
    for _, mode in pairs(keymap.mode) do
      if mode.enable then
        table.insert(modes, mode.code)
      end
    end
  end

  keymap.opts = keymap.opts or opts or {}
  vim.keymap.set(modes, keymap.lhs, keymap.rhs, keymap.opts)
end

---Bind @keymaps using `vim.keymap.set` API
---
---@param keymaps KeymapDef|KeymapDef[]
---@param opts KeymapArgs @global opts
function Keymap.bind(keymaps, opts)
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

---Function modifier to append `<Plug>` to `fn`
---@param fn string @ex command
---@return string
function Keymap.modifier.plug(fn)
  return ("<Plug>%s"):format(fn)
end

---Key modifier to append `<Leader>` to KeymapDef.lhs
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
---@param code string
---@param map KeymapDef
---@return KeymapDef
local function mapmode(mode, code, map)
  map.mode[mode] = { enable = true, code = code }
  return map
end

---Assign normal mode(`n`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.normal(map)
  return mapmode("normal", "n", map)
end

---Assign insert mode(`i`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.insert(map)
  return mapmode("insert", "i", map)
end

---Assign visual-select mode(`v`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.vselect(map)
  return mapmode("visual-select", "v", map)
end

---Assign select mode(`s`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.select(map)
  return mapmode("select", "s", map)
end

---Assign visual mode(`x`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.visual(map)
  return mapmode("visual", "x", map)
end

---Assign operator-pending mode(`o`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.opending(map)
  return mapmode("operator-pending", "o", map)
end

---Assign command-line mode(`c`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.cmd(map)
  return mapmode("command-line", "c", map)
end

---Assign insert-commandline mode(`!`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.icmd(map)
  return mapmode("insert-commandline", "!", map)
end

---Assign terminal mode(`t`) to @map
---@param map KeymapDef
---@return KeymapDef definition
function Keymap.mode.terminal(map)
  return mapmode("terminal", "t", map)
end

return Keymap
