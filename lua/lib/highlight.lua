local Highlight = {}

---Get the foreground color of `group_name` highlight group
---
---@param group_name string
---@return string ##RRGGBB
function Highlight.fg(group_name)
  local hl = vim.api.nvim_get_hl_by_name(group_name, true)
  return hl.foreground and ("#%06x"):format(hl.foreground) or "NONE"
end

---Get the background color of `group_name` highlight group
---
---@param group_name string
---@return string ##RRGGBB
function Highlight.bg(group_name)
  local hl = vim.api.nvim_get_hl_by_name(group_name, true)
  return hl.background and ("#%06x"):format(hl.background) or "NONE"
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

---Parse HighlightDef into highlight definition map
---
---@param hl HighlightDef
---@return table def # highlight definition map, see `:h nvim_get_hl_by_name`
local function parse_def(hl)
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
    inherit = vim.api.nvim_get_hl_by_name(hl.inherit, true) or {}
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
  vim.api.nvim_set_hl(0, name, parse_def(def))
end

---Link `hl` to `hl_source` highlight group
---
---@param hl string #highlight group name
---@param hl_source string #highlight group name to be linked
function Highlight.link(hl, hl_source)
  vim.api.nvim_set_hl(0, hl, { link = hl_source })
end

return Highlight
