local config = {}

config.globalStatus = true

require("kanagawa").setup(config)

vim.cmd("colorscheme kanagawa")

local c = require("kanagawa.colors").setup()

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend

  -- highlight-default
  link("FloatBorder", "Normal")
  set("NonText", { inherit = "NonText", bold = false })
  link("NormalFloat", "Normal")
  set("TabLine", { inherit = "StatusLine", fg = c.oldWhite })
  link("TabLineFill", "TabLine")
  link("TabLineSel", "Normal")
  set("VertSplit", { fg = bg("StatusLine") })
  link("WinSeparator", "VertSplit")

  -- plugin
  link("CmpDocumentationBorder", "LineNr")
  set("HopNextKey", { fg = c.peachRed, bold = true })
  set("HopNextKey1", { fg = c.springGreen, bold = true })
  set("HopNextKey2", { fg = c.waveBlue2 })
  set("HopUnmatched", { fg = c.sumiInk4, special = c.sumiInk4 })
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLineNC", fg = fg("NonText") })
  set("InclineWinNr", {
    fg = fg("CursorLineNr"),
    bg = blend(fg("CursorLineNr"), bg("StatusLine"), 0.1),
  })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("ModesCopy", { bg = bg("IncSearch") })
  set("ModesDelete", { bg = c.autumnRed })
  set("ModesInsert", { bg = c.fujiWhite })
  set("ModesVisual", { bg = c.oniViolet })
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
  set("TreesitterContext", { bg = bg("StatusLine") })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
