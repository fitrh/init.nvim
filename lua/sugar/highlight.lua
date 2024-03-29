local Highlight = {}
local a = vim.api
local hi = { set = a.nvim_set_hl, get = a.nvim_get_hl_by_name }

---@class RGBTable
---@field r number
---@field g number
---@field b number

---Convert hex (#RRGGBB) to RGBTable { r, g, b }
---@param hex string @#RRGGBB
---@return RGBTable
local function rgb(hex)
  local rrggbb = string.gsub(hex, "#", "")
  local r = rrggbb:sub(1, 2)
  local g = rrggbb:sub(3, 4)
  local b = rrggbb:sub(5, 6)
  return { r = tonumber(r, 16), g = tonumber(g, 16), b = tonumber(b, 16) }
end

---Convert RGB decimal to hexadecimal (#RRGGBB)
---@param dec number|string
---@return string color @#RRGGBB
local function hex(dec)
  return ("#%06x"):format(dec)
end

---@param attr HighlightAttribute
---@param groups? table @highlight group list
---@param color? number|string
---@return number|string hex @#RRGGBB attr value
local function fallback(attr, groups, color)
  for _, group in ipairs(groups or {}) do
    local valid, value = pcall(hi.get, group, true)
    if valid and value[attr] then
      return hex(value[attr])
    end
  end

  return color and color or "NONE"
end

---@alias HighlightAttribute
---| '"foreground"'
---| '"background"'

---Get the attributes of highlight group
---@param attr HighlightAttribute
---@param group string
---@param fallbacks? table @highlight group list
---@param color? number|string @fallback color
---@return number|string ##RRGGBB | NONE
local function get(attr, group, fallbacks, color)
  local valid, value = pcall(hi.get, group, true)
  if not valid then
    if not fallbacks and color then
      return color
    end
    return fallback(attr, fallbacks, color)
  end

  return value[attr] and hex(value[attr]) or fallback(attr, fallbacks, color)
end

---Blend `top` over `bottom` to get pseudo-transparent color
---@param top string|fun():string @hex color (#RRGGBB)
---@param bottom string|fun():string @hex color (#RRGGBB)
---@param alpha number @blend intensity, float (0.0 - 1.0) or integer (0 - 100)
---@return fun():string @#RRGGBB
function Highlight.blend(top, bottom, alpha)
  return function()
    local a = alpha > 1 and (alpha / 100) or alpha
    local b = rgb(type(bottom) == "function" and bottom() or bottom)
    local t = rgb(type(top) == "function" and top() or top)

    local function blend(c)
      c = (a * t[c] + ((1 - a) * b[c]))
      return math.floor(math.min(math.max(0, c), 255) + 0.5)
    end

    return ("#%02X%02X%02X"):format(blend("r"), blend("g"), blend("b"))
  end
end

---Get the foreground color of `from_group` highlight group
---@param from_group string
---@param or_fallbacks? table @list of fallback highlight groups
---@param or_color? string @fallback color
---@return fun():number|string ##RRGGBB | NONE
function Highlight.fg(from_group, or_fallbacks, or_color)
  return function()
    return get("foreground", from_group, or_fallbacks, or_color)
  end
end

---Get the background color of `from_group` highlight group
---@param from_group string
---@param or_fallbacks? table @list of fallback highlight groups
---@param or_color? string @fallback color
---@return fun():number|string ##RRGGBB | NONE
function Highlight.bg(from_group, or_fallbacks, or_color)
  return function()
    return get("background", from_group, or_fallbacks, or_color)
  end
end

---@class HighlightDef
---@field inherit? string
---@field fg? string|"fg"|"NONE"|nil|fun():string
---@field bg? string|"bg"|"NONE"|nil|fun():string
---@field sp? string|"NONE"|nil|fun():string
---@field blend? number
---@field italic? boolean
---@field bold? boolean
---@field underline? boolean
---@field underdouble? boolean
---@field undercurl? boolean
---@field underdotted? boolean
---@field underdashed? boolean
---@field strikethrough? boolean
---@field reverse? boolean
---@field standout? boolean
---@field default? boolean
---@field nocombine? boolean
---@field ctermfg? number
---@field ctermbg? number
---@field cterm? table
---@field link? boolean|string

---Parse HighlightDef into highlight definition map to be used by `nvim_set_hl`
---@param hl HighlightDef
---@return table def highlight definition map, see `:h nvim_get_hl_by_name`
local function parse(hl)
  local def = {}

  for _, attribute in pairs({ "default", "nocombine" }) do
    if hl[attribute] ~= nil then
      def[attribute] = hl[attribute]
    end
  end

  if hl.link and type(hl.link) == "string" and pcall(hi.get, hl.link, true) then
    def.link = hl.link
    return def
  end

  local attributes = {
    "blend",
    "italic",
    "bold",
    "underline",
    "underdouble",
    "undercurl",
    "underdotted",
    "underdashed",
    "strikethrough",
    "reverse",
    "standout",
  }

  local additional_attributes = {
    "ctermfg",
    "ctermbg",
    "cterm",
  }

  ---@type boolean|table
  local inherit = {}

  if hl.inherit then
    local ok, value = pcall(hi.get, hl.inherit, true)
    inherit = (ok and value) and value or inherit
  end

  for _, attr in ipairs({ "fg", "bg", "sp" }) do
    hl[attr] = type(hl[attr]) == "function" and hl[attr]() or hl[attr]
  end

  def.foreground = hl.fg or inherit.foreground or "NONE"
  def.background = hl.bg or inherit.background or "NONE"
  def.special = hl.sp or inherit.special or "NONE"
  def.italic = inherit.italic or false
  def.bold = inherit.bold or false
  def.underline = inherit.underline or false
  def.underdouble = inherit.underdouble or false
  def.undercurl = inherit.undercurl or false
  def.underdotted = inherit.underdotted or false
  def.underdashed = inherit.underdashed or false
  def.strikethrough = inherit.strikethrough or false
  def.reverse = inherit.reverse or false
  def.standout = inherit.standout or false

  -- `blend` field is not set by default
  -- set it only if the inherited group is set
  if inherit.blend then
    def.blend = inherit.blend
  end

  for _, attribute in pairs(attributes) do
    if hl[attribute] ~= nil then
      def[attribute] = hl[attribute]
    end
  end

  for _, attribute in pairs(additional_attributes) do
    if hl[attribute] ~= nil then
      def[attribute] = hl[attribute]
    end
  end

  return def
end

---Create or set highlight group using vim.api.nvim_set_hl
---@param name string #highlight group name
---@param def HighlightDef #table of HighlightDef
function Highlight.set(name, def)
  hi.set(0, name, parse(def))
end

---Link `dest` to `source` highlight group
---@param dest string #highlight group name
---@param source string #highlight group name to be linked
function Highlight.link(dest, source)
  hi.set(0, dest, {})
  hi.set(0, dest, { link = source })
end

---@class HighlightCallbackParam
---@field set fun(name:string, def:HighlightDef)
---@field link fun(dest:string, source:string)
---@field fg fun(group:string, fallback_groups?:table, fallback_color?:string)
---@field bg fun(group:string, fallback_groups?:table, fallback_color?:string)
---@field blend fun(top:string|fun(), bottom:string|fun(), alpha:number)

---Set colorscheme
---@param callback fun(h:HighlightCallbackParam)
function Highlight.colorscheme(callback)
  callback({
    set = Highlight.set,
    link = Highlight.link,
    fg = Highlight.fg,
    bg = Highlight.bg,
    blend = Highlight.blend,
  })
end

return Highlight
