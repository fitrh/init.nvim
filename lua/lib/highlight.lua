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

---Get the foreground color of `group_name` highlight group
---
---@param group_name string
---@return string ##RRGGBB | NONE
function Highlight.fg(group_name)
  local hl = api.get(group_name, true)
  return hl.foreground and tohex(hl.foreground) or "NONE"
end

---Get the background color of `group_name` highlight group
---
---@param group_name string
---@return string ##RRGGBB | NONE
function Highlight.bg(group_name)
  local hl = api.get(group_name, true)
  return hl.background and tohex(hl.background) or "NONE"
end

---@class HighlightDef
---@field inherit string
---@field fg string
---@field bg string
---@field special string
---@field italic boolean
---@field bold boolean
---@field undercurl boolean
---@field underline boolean
---@field strikethrough boolean
---@field reverse boolean
---@field standout boolean
---
---Parse HighlightDef into highlight definition map to be used by `nvim_set_hl`
---
---@param hl HighlightDef
---@return table def highlight definition map, see `:h nvim_get_hl_by_name`
local function parse(hl)
  local styles = {
    "italic",
    "bold",
    "underline",
    "undercurl",
    "strikethrough",
    "reverse",
    "standout",
  }
  local inherit = {}

  if hl.inherit then
    inherit = api.get(hl.inherit, true) or {}
  end

  local def = {
    foreground = hl.fg or inherit.foreground or "NONE",
    background = hl.bg or inherit.background or "NONE",
    special = hl.special or inherit.special or "NONE",
    italic = inherit.italic or false,
    bold = inherit.bold or false,
    underline = inherit.underline or false,
    undercurl = inherit.undercurl or false,
    strikethrough = inherit.strikethrough or false,
    reverse = inherit.reverse or false,
    standout = inherit.standout or false,
  }

  for _, style in pairs(styles) do
    if hl[style] ~= nil then
      def[style] = hl[style]
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
