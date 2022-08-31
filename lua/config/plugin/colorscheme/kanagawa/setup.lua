local config = {}

config.globalStatus = true

require("kanagawa").setup(config)

vim.cmd.colorscheme("kanagawa")

local c = require("kanagawa.colors").setup()

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend

  -- highlight-default
  set("ColorColumn", { bg = blend(bg("StatusLine"), bg("Normal"), 0.3) })
  set("CursorColumn", { bg = blend(bg("CursorLine"), bg("Normal"), 0.2) })
  link("CursorLine", "CursorColumn")
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  set("Folded", { inherit = "Folded", bg = "NONE" })
  set("NonText", { inherit = "NonText", bold = false })
  set("TabLine", { inherit = "StatusLine", fg = c.fujiGray })
  link("TabLineFill", "TabLine")
  link("TabLineSel", "Normal")
  set("VertSplit", { fg = bg("StatusLine") })
  link("WinSeparator", "VertSplit")

  -- plugin
  link("CmpCursorLine", "CursorLine")
  link("FloatTitle", "Title")
  for i, p in ipairs({
    "springViolet1",
    "autumnGreen",
    "waveAqua1",
    "boatYellow2",
    "oniViolet",
  }) do
    set(("HeadLine%d"):format(i), { fg = c[p], bg = blend(c[p], c.bg, 0.05) })
  end
  set("HopNextKey", { fg = c.peachRed, bold = true })
  set("HopNextKey1", { fg = c.springGreen, bold = true })
  set("HopNextKey2", { fg = c.waveBlue2 })
  set("HopUnmatched", { fg = c.sumiInk4, special = c.sumiInk4 })
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLineNC", fg = fg("NonText") })
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineWinNr", {
    fg = fg("CursorLineNr"),
    bg = blend(fg("CursorLineNr"), bg("StatusLine"), 0.1),
  })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("ModesCopy", { bg = bg("IncSearch") })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = c.autumnRed })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = c.autumnGreen })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = c.oniViolet })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })
  link("NotifyTRACEBorder", "DiagnosticHint")
  link("NotifyTRACETitle", "NotifyTRACEBorder")
  link("NotifyTRACEIcon", "NotifyTRACEBorder")
  set("NotifyDEBUGBorder", { fg = c.fujiGray })
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
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.springViolet1 })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.autumnRed })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLinePathSep", {
    inherit = "StatusLine",
    fg = c.boatYellow1,
    bold = true,
  })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.samuraiRed })
  set("StatusLineMNormal", { fg = c.crystalBlue })
  set("StatusLineMInsert", { fg = c.autumnGreen })
  set("StatusLineMVisual", { fg = c.oniViolet })
  set("StatusLineMReplace", { fg = c.autumnRed })
  set("StatusLineMCommand", { fg = c.boatYellow2 })
  set("TabLineModified", { inherit = "TabLine", fg = c.autumnRed })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.autumnRed })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.crystalBlue })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = fg("LineNr"),
  })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
