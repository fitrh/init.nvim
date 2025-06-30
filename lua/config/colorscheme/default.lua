local a = vim.api
local function hex(c)
  if type(c) ~= "string" then
    return string.format("%06X", c)
  end

  local named_color = a.nvim_get_color_by_name(c)
  if named_color ~= -1 then
    c = named_color
  end

  return string.format("%06X", c)
end

---@param c string "#rrggbb" color format
---@return { r: number, g: number, b: number }
local function rgb(c)
  local rrggbb = string.gsub(c, "#", "")
  local r = rrggbb:sub(1, 2)
  local g = rrggbb:sub(3, 4)
  local b = rrggbb:sub(5, 6)
  return { r = tonumber(r, 16), g = tonumber(g, 16), b = tonumber(b, 16) }
end

local function blend(top, bottom, alpha)
  if alpha > 1 then
    alpha = (alpha / 100)
  end
  bottom = rgb(hex(bottom))
  top = rgb(hex(top))

  local function channel(c)
    c = (alpha * top[c] + ((1 - alpha) * bottom[c]))
    return math.floor(math.min(math.max(0, c), 255) + 0.5)
  end

  return ("#%02X%02X%02X"):format(channel("r"), channel("g"), channel("b"))
end

local theme = { fg = "Light", bg = "Dark" }
local light = a.nvim_get_option_value("background", {}) == "light"
if light then
  theme = { fg = "Dark", bg = "Light" }
end

---@alias Grey "Grey1" | "Grey2" | "Grey3" | "Grey4"
---@alias Color "Red" | "Green" | "Blue" | "Yellow" | "Cyan" | "Magenta" | Grey
---@type table<Color, { fg: string, bg: string }>
local c = {}
for i = 1, 4 do
  c["Grey" .. i] = {
    fg = "Nvim" .. theme.fg .. "Grey" .. i,
    bg = "Nvim" .. theme.bg .. "Grey" .. i,
  }
end
for _, v in ipairs({ "Blue", "Cyan", "Green", "Magenta", "Red", "Yellow" }) do
  c[v] = {
    fg = "Nvim" .. theme.fg .. v,
    bg = "Nvim" .. theme.bg .. v,
  }
end

---@param group string
---@return vim.api.keyset.get_hl_info
local function get(group)
  return a.nvim_get_hl(0, { name = group, link = false })
end

local Normal = get("Normal")

local function nblend(top, alpha)
  return blend(top, Normal.bg, alpha)
end

---@param fg string
---@param bottom number|string
---@param alpha? number|vim.api.keyset.highlight
---@param attr? vim.api.keyset.highlight
---@return vim.api.keyset.highlight
local function fblend(fg, bottom, alpha, attr)
  if not attr and alpha and type(alpha) == "table" then
    attr = alpha
    alpha = nil
  end

  if not alpha and type(bottom) == "number" then
    alpha = bottom
    bottom = Normal.bg
  end

  local def = { fg = fg, bg = blend(fg, bottom, alpha) }
  for k, v in pairs(attr or {}) do
    def[k] = v
  end

  return def
end

---@param group string Name
---@param def vim.api.keyset.highlight Definition
local function hi(group, def)
  a.nvim_set_hl(0, group, def)
end

-- :h terminal-config
local g = a.nvim_set_var
g("terminal_color_0", c.Grey2.bg)
g("terminal_color_1", c.Red.fg)
g("terminal_color_2", c.Green.fg)
g("terminal_color_3", c.Yellow.fg)
g("terminal_color_4", c.Blue.fg)
g("terminal_color_5", c.Magenta.fg)
g("terminal_color_6", c.Cyan.fg)
g("terminal_color_7", c.Grey2.fg)
g("terminal_color_8", c.Grey2.bg)
g("terminal_color_9", c.Red.fg)
g("terminal_color_10", c.Green.fg)
g("terminal_color_11", c.Yellow.fg)
g("terminal_color_12", c.Blue.fg)
g("terminal_color_13", c.Magenta.fg)
g("terminal_color_14", c.Cyan.fg)
g("terminal_color_15", c.Grey2.fg)

-- :h group-name
-- hi("Type", { bold = true })

-- :h highlight-default
hi("CursorLineNr", { fg = "fg", bold = true })
hi("Folded", fblend(c.Grey2.fg, 0.05))
hi("PmenuSel", { bg = c.Grey4.bg })
hi("StatusLine", { fg = c.Grey3.fg, bg = c.Grey1.bg })
hi("StatusLineNC", { fg = c.Grey4.bg, bg = c.Grey1.bg })
hi("TabLineSel", { fg = "fg", bg = "bg", bold = true })
if a.nvim_get_option_value("laststatus", {}) == 3 then
  hi("WinSeparator", { fg = c.Grey1.bg })
else
  hi("WinSeparator", { fg = c.Grey1.bg, bg = c.Grey1.bg })
end

-- :h diagnostic-highlights
for _, v in ipairs({ "Ok", "Hint", "Info", "Warn", "Error" }) do
  local group = "DiagnosticUnderline" .. v
  local def = get(group)
  def.undercurl = false
  def.underline = false
  def.bg = nblend(def.sp, light and 0.15 or 0.1)
  hi(group, def)
end
-- hi("DiagnosticDeprecated", { fg = c.Grey4.fg, strikethrough = true })
-- hi("DiagnosticDeprecated", fblend(c.Grey4.fg, 0.1))
-- hi("DiagnosticUnnecessary", fblend(c.Grey4.fg, 0.1))

-- :h treesitter-highlight-groups
-- comment annotation test
-- FIXME ERROR comment contents
-- WARNING FIX comment contents
-- TODO WIP comment contents
-- NOTE SEE comment contents
hi("@comment.error", fblend(c.Red.fg, 0.1, { bold = true }))
hi("@comment.note", fblend(c.Cyan.fg, 0.1))
hi("@comment.todo", fblend(c.Grey2.fg, 0.1))
hi("@comment.warning", fblend(c.Yellow.fg, 0.1))
hi("@keyword.import", { fg = c.Grey3.fg })
hi("@markup.link", fblend(c.Blue.fg, 0.1))
hi("@operator", { fg = c.Grey2.fg, bold = true })
hi("@variable", { fg = c.Grey2.fg })
hi("@string.special.url", fblend(c.Blue.fg, 0.1))
hi("@tag.attribute", { fg = c.Grey3.fg, bold = true })
hi("@tag", { fg = c.Grey3.fg })
-- hi("@diff.plus", { fg = c.Green.fg })
-- hi("@diff.plus", fblend(c.Green.fg, 0.1))
hi("@diff.plus", { bg = nblend(c.Green.bg, 0.3) })
-- hi("@diff.minus", { fg = c.Red.fg })
-- hi("@diff.minus", fblend(c.Red.fg, 0.1))
hi("@diff.minus", { bg = nblend(c.Red.bg, 0.3) })

-- lsp-semantic-highlight
-- hi("@lsp.type.variable", { link = "@variable" }) -- upstreamed, SEE https://github.com/neovim/neovim/pull/22981

-- :h lsp-highlight
hi("LspCodeLens", { link = "LineNr" })
hi("LspReferenceRead", { bg = c.Grey4.bg })
hi("LspReferenceWrite", { bg = c.Grey4.bg, bold = true })
hi("LspSignatureActiveParameter", { fg = c.Grey1.fg, bg = c.Yellow.bg })

-- ft:diff
hi("diffAdded", { fg = c.Green.fg })
hi("diffChanged", { fg = c.Blue.fg })
hi("diffRemoved", { fg = c.Red.fg })

-- ft:man
hi("manReference", { link = "Identifier" })

-- custom
hi("GhostLineNr", { fg = "bg", bg = "bg" })

-- cmp
hi("CmpCursorLine", { link = "PmenuSel" })
hi("CmpDoc", { link = "NormalFloat" })
hi("CmpItemAbbrMatch", { fg = c.Yellow.fg })
hi("CmpItemAbbrMatchFuzzy", { link = "Special" })

-- gitsigns
hi("GitSignsAdd", { fg = c.Green.fg })
hi("GitSignsChange", { fg = c.Blue.fg })
hi("GitSignsDelete", { fg = c.Red.fg })
hi("GitSignsCurrentLineBlame", { link = "Comment" })

-- incline
hi("InclineNormalNc", { link = "StatusLineNC" })
-- hi("InclineSep", { link = "StatusLineDim" })
hi("InclineSep", { fg = c.Grey4.bg, bold = true })
hi("InclineTail", { bold = true })
hi(
  "InclineWinNr",
  fblend(c.Yellow.fg, c.Grey1.bg, light and 0.2 or 0.15, { bold = true })
)

-- modes
hi("ModesCopy", { bg = c.Yellow.fg })
hi("ModesCopyCursorLine", { bg = nblend(c.Yellow.bg, light and 0.3 or 0.15) })
hi("ModesCopyCursorLineNr", { fg = c.Yellow.fg, bold = true })

hi("ModesInsert", { bg = c.Green.fg })
hi("ModesInsertCursorLineNr", { fg = c.Green.fg, bold = true })

hi("ModesVisual", { bg = c.Grey4.fg })
hi("ModesVisualCursorLineNr", { fg = c.Grey4.fg, bold = true })
-- hi("ModesVisualCursorLineNr", { fg = c.Magenta.fg, bold = true })

hi("ModesDelete", { bg = c.Red.fg })
hi("ModesDeleteCursorLineNr", { fg = c.Red.fg, bold = true })

-- Neogit
hi("NeogitActiveItem", { bg = nblend(c.Yellow.bg, 0.3) })
hi("NeogitDiffAdd", { bg = nblend(c.Green.bg, 0.3) })
hi("NeogitDiffDelete", { bg = nblend(c.Red.bg, 0.3) })

-- neotest
hi("NeotestAdapterName", { fg = c.Red.fg, bold = true })
hi("NeotestDir", { fg = c.Blue.fg, bold = true })
hi("NeotestFile", { fg = c.Cyan.fg })
hi("NeotestTest", { fg = c.Grey1.fg })
hi("NeotestUnknown", { fg = c.Grey3.fg })
hi("NeotestPassed", { fg = c.Green.fg })
hi("NeotestNamespace", { fg = c.Magenta.fg })

-- notify
local alpha = light and 0.2 or 0.1
hi("NotifyTRACETitle", fblend(c.Magenta.fg, c.Grey1.bg, alpha))
hi("NotifyDEBUGTitle", fblend(c.Grey4.fg, c.Grey1.bg, alpha))
hi("NotifyINFOTitle", fblend(c.Blue.fg, c.Grey1.bg, alpha))
hi("NotifyWARNTitle", fblend(c.Yellow.fg, c.Grey1.bg, alpha))
hi("NotifyERRORTitle", fblend(c.Red.fg, alpha))
for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
  local link = "Notify" .. v .. "Title"
  local notify = get(link)
  hi("Notify" .. v .. "Body", { link = link })
  hi("Notify" .. v .. "Icon", { link = link })
  hi("Notify" .. v .. "Border", { fg = notify.bg, bg = notify.bg })
end

-- statusline
local function stl(group, def)
  group = "StatusLine" .. group
  hi(group, def)
end

local stl_hl = get("StatusLine")
if vim.version().minor < 11 then
  -- NOTE: only needed before [#29976](https://github.com/neovim/neovim/pull/29976)
  local _stl = stl
  function stl(group, def)
    if not def.fg then
      def.fg = stl_hl.fg
    end

    if not def.bg then
      def.bg = stl_hl.bg
    end
    _stl(group, def)
  end
end

for _, v in ipairs({ "Hint", "Info", "Warn", "Error" }) do
  v = "Diagnostic" .. v
  local hl = get(v)
  stl(v .. "Count", { fg = hl.fg, bold = true })
  stl(v .. "Sign", { fg = blend(hl.fg, stl_hl.bg, 0.75) })
end
stl("Dim", { fg = c.Grey4.bg })
stl("Filename", { bold = true })
stl("FilenameMod", { fg = c.Red.fg, bold = true })
-- stl("GitDiffAdd", { fg = c.Green.fg })
-- stl("GitDiffChange", { fg = c.Blue.fg })
-- stl("GitDiffDelete", { fg = c.Red.fg })
stl("GitDiffAddCount", { fg = c.Green.fg, bold = true })
stl("GitDiffAddSign", { fg = c.Green.fg })
stl("GitDiffChangeCount", { fg = c.Blue.fg, bold = true })
stl("GitDiffChangeSign", { fg = c.Blue.fg })
stl("GitDiffDeleteCount", { fg = c.Red.fg, bold = true })
stl("GitDiffDeleteSign", { fg = c.Red.fg })
stl("Modified", { fg = c.Blue.fg })
stl("Path", { fg = c.Grey4.fg })
stl("PathSep", { fg = c.Grey4.bg })
stl("RO", { fg = get("DiagnosticError").fg })
-- stl("WinNr", { fg = c.Yellow.fg, bold = true })
stl(
  "WinNr",
  fblend(c.Yellow.fg, stl_hl.bg, light and 0.2 or 0.15, { bold = true })
)

-- tabline
-- hi("TabLineModified", { link = "TabLine" })
-- hi("TabLineSep", { link = "TabLine" })
-- hi("TabLineModifiedSel", { link = "TabLineSel" })
-- hi("TabLineSepSel", { link = "TabLineSel" })

-- telescope
hi("TelescopeMatching", { fg = c.Cyan.fg, bold = true })
hi("TelescopeNormal", { link = "StatusLine" })
hi("TelescopeBorder", { fg = c.Grey1.bg, bg = c.Grey1.bg })
hi("TelescopeTitle", { fg = c.Grey3.fg, bg = c.Grey3.bg })
