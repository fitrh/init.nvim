local api = vim.api
local get_hl = api.nvim_get_hl

---@param group string
---@param attr? "fg"|"bg"|"sp"
---@return string|table
local function get(group, attr)
  local def = get_hl(0, { name = group, link = false })
  if not def then
    return "NONE"
  end

  if not attr then
    return def
  end

  return def[attr] or "NONE"
end

local set_hl = api.nvim_set_hl
local function hi(group, def)
  set_hl(0, group, def)
end

local function ov(group, def)
  local orig = get(group)
  for key, value in pairs(def) do
    orig[key] = value
  end

  hi(group, orig)
end

hi("LineNr", { fg = get("LineNr", "fg"), bg = "bg" })
ov("CursorLineNr", { bg = "bg" })
-- hi("NormalFloat", { bg = get("FloatBorder", "bg") })
hi("PmenuSel", { bg = get("PmenuSel", "bg") })

hi("CmpCursorLine", { link = "PmenuSel" })
hi("CmpDoc", { link = "NormalFloat" })

ov("StatusLine", { reverse = false })
local StatusLine = get("StatusLine")
local function statusline(group, def)
  group = "StatusLine" .. group
  for _, attr in ipairs({ "fg", "bg" }) do
    if not def[attr] then
      def[attr] = StatusLine[attr]
    end
  end
  hi(group, def)
end
statusline("Filename", { bold = true })
statusline("GitDiffAdd", { fg = get("diffAdded", "bg") })
statusline("GitDiffCahange", { fg = get("DiffCahange", "bg") })
statusline("GitDiffDelete", { fg = get("diffRemoved", "bg") })

-- hi("TabLineModified", { link = "TabLine" })
-- hi("TabLineSep", { link = "TabLine" })
-- hi("TabLineModifiedSel", { link = "TabLineSel" })
-- hi("TabLineSepSel", { link = "TabLineSel" })

hi("TelescopeNormal", { link = "NormalFloat" })
hi("TelescopeBorder", { link = "FloatBorder" })
