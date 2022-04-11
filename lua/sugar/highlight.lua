local Highlight = {}
local api = {
  set = vim.api.nvim_set_hl,
  get = vim.api.nvim_get_hl_by_name,
}

---Convert to hexadecimal (#RRGGBB)
---@param str string
---@return string color ##RRGGBB
local function tohex(str)
  return ("#%06x"):format(str)
end

---@alias HighlightAttribute
---| '"foreground"'
---| '"background"'

---Get the attributes of highlight group
---@param attr HighlightAttribute
---@param group string
---@param fallbacks table
---@return string ##RRGGBB | NONE
local function get(attr, group, fallbacks)
  local hl = {}
  -- validate the highlight group
  hl.valid, hl.value = pcall(api.get, group, true)

  -- if `group` is invalid or the `attr` is unavailable for `group`
  if not hl.valid or not hl.value[attr] then
    -- we are provide `fallbacks`
    -- try extracting valid groups with `attr` available
    if fallbacks then
      for _, fallback in ipairs(fallbacks) do
        hl.valid, hl.value = pcall(api.get, fallback, true)
        if hl.valid and hl.value[attr] then
          return tohex(hl.value[attr])
        end
      end
    end

    -- none of the groups provided are valid
    return "NONE"
  end

  return tohex(hl.value[attr])
end

---Get the foreground color of `from_group` highlight group
---
---@param from_group string
---@param or_fallbacks? table list of highlight groups
---@return string ##RRGGBB | NONE
function Highlight.fg(from_group, or_fallbacks)
  return get("foreground", from_group, or_fallbacks or nil)
end

---Get the background color of `from_group` highlight group
---
---@param from_group string
---@param or_fallbacks? table list of highlight groups
---@return string ##RRGGBB | NONE
function Highlight.bg(from_group, or_fallbacks)
  return get("background", from_group, or_fallbacks or nil)
end

---@class HighlightDef
---@field inherit string
---@field fg string
---@field bg string
---@field special string
---@field blend number
---@field italic boolean
---@field bold boolean
---@field underline boolean
---@field underlineline boolean
---@field undercurl boolean
---@field underdot boolean
---@field underdash boolean
---@field strikethrough boolean
---@field reverse boolean
---@field standout boolean
---@field default boolean
---@field nocombine boolean
---@field ctermfg number
---@field ctermbg number
---@field cterm table
---@field link boolean|string

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

  if
    hl.link
    and type(hl.link) == "string"
    and pcall(api.get, hl.link, true)
  then
    def.link = hl.link
    return def
  end

  local attributes = {
    "blend",
    "italic",
    "bold",
    "underline",
    "underlineline",
    "undercurl",
    "underdot",
    "underdash",
    "strikethrough",
    "reverse",
    "standout",
  }

  local additional_attributes = {
    "ctermfg",
    "ctermbg",
    "cterm",
  }

  local inherit = {}

  if hl.inherit then
    local ok, value = pcall(api.get, hl.inherit, true)
    inherit = ok and value
  end

  def.foreground = hl.fg or inherit.foreground or "NONE"
  def.background = hl.bg or inherit.background or "NONE"
  def.special = hl.special or inherit.special or "NONE"
  def.italic = inherit.italic or false
  def.bold = inherit.bold or false
  def.underline = inherit.underline or false
  def.underlineline = inherit.underlineline or false
  def.undercurl = inherit.undercurl or false
  def.underdot = inherit.underdot or false
  def.underdash = inherit.underdash or false
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
---
---@param name string #highlight group name
---@param def HighlightDef #table of HighlightDef
function Highlight.set(name, def)
  api.set(0, name, parse(def))
end

---Link `dest` to `source` highlight group
---
---@param dest string #highlight group name
---@param source string #highlight group name to be linked
function Highlight.link(dest, source)
  api.set(0, dest, { link = source })
end

return Highlight
