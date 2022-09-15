local function get_variant()
  local variants = { storm = "storm", night = "night", day = "day" }
  return variants[os.getenv("NVIM_TOKYONIGHT_VARIANT")] or "night"
end

local config = {}
config.style = get_variant()
config.sidebars = { "qf" }
require("tokyonight").load(config)

local c = require("tokyonight.colors").setup(config)
local u = require("tokyonight.util")

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local br_red = u.lighten(c.red, 0.2, c.red)

  -- highlight-default
  set("ColorColumn", { bg = blend(c.bg_statusline, c.bg, 0.4) })
  set("CursorColumn", { bg = blend(c.blue, c.bg, 0.05) })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { fg = c.blue })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("Folded", "LineNr")
  link("TabLineSel", "Normal")
  link("TabLine", "StatusLineNC")
  link("TabLineFill", "TabLine")
  set("VertSplit", { fg = c.bg_statusline, cterm = { reverse = true } })

  -- treesitter
  set("TSConstBuiltin", { fg = c.red })

  -- plugin
  link("CmpCursorLine", "CursorLine")
  link("FloatTitle", "Title")
  local p = { "magenta", "cyan", "green", "orange", "yellow", "purple" }
  for i, v in ipairs(p) do
    set(("HeadLine%d"):format(i), { fg = c[v], bg = blend(c[v], c.bg, 0.05) })
  end
  link("InclineNormal", "StatusLine")
  link("InclineNormalNC", "StatusLineNC")
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineWinNr", { fg = c.blue, bg = blend(c.blue, c.bg_statusline, 0.1) })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("ModesCopy", { bg = bg("IncSearch") })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = c.red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = c.green })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = c.purple })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })
  link("NotifyTRACEBorder", "DiagnosticHint")
  link("NotifyTRACETitle", "NotifyTRACEBorder")
  link("NotifyTRACEIcon", "NotifyTRACEBorder")
  set("NotifyDEBUGBorder", { fg = c.fg_dark })
  link("NotifyDEBUGTitle", "NotifyDEBUGBorder")
  link("NotifyDEBUGIcon", "NotifyDEBUGBorder")
  link("NotifyINFOBorder", "DiagnosticInfo")
  link("NotifyINFOTitle", "NotifyINFOBorder")
  link("NotifyINFOIcon", "NotifyINFOBorder")
  link("NotifyWARNBorder", "DiagnosticWarn")
  link("NotifyWARNTitle", "NotifyWARNBorder")
  link("NotifyWARNIcon", "NotifyWARNBorder")
  link("NotifyERRORBorder", "DiagnosticError")
  link("NotifyERRORTitle", "NotifyERRORBorder")
  link("NotifyERRORIcon", "NotifyERRORBorder")
  set("StatusLineDim", { inherit = "StatusLine", fg = c.dark3 })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.purple })
  for _, kind in ipairs({ "Add", "Change", "Delete" }) do
    local group = ("StatusLineGitDiff%s"):format(kind)
    set(group, { inherit = "StatusLine", fg = c.gitSigns[kind:lower()] })
  end
  set("StatusLineModified", { inherit = "StatusLine", fg = br_red })
  link("StatusLinePath", "StatusLineNC")
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.red1 })
  set("StatusLineMNormal", { fg = c.blue })
  set("StatusLineMInsert", { fg = c.green })
  set("StatusLineMVisual", { fg = c.purple })
  set("StatusLineMReplace", { fg = c.red })
  set("StatusLineMCommand", { fg = c.yellow })
  set("TabLineModified", { inherit = "TabLine", fg = br_red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = br_red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.blue })
  set("TelescopeNormal", { bg = c.bg_statusline })
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = c.bg_statusline, fg = c.bg_statusline })
  set("TodoLink", { fg = c.blue0 })
  set("TodoOk", { fg = c.dark5 })
  set("TodoTest", { fg = c.magenta2 })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = fg("LineNr"),
  })
  set("WinSeparatorZen", { fg = c.bg })
end)
