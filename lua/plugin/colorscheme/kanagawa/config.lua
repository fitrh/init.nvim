local config = {}

config.globalStatus = true

require("kanagawa").setup(config)

vim.cmd("colorscheme kanagawa")

local c = require("kanagawa.colors").setup()
local hi = require("sugar.highlight")

hi.colorscheme({
  -- highlight-default
  { "FloatBorder", link = "Normal" },
  { "NonText", inherit = "NonText", bold = false },
  { "NormalFloat", link = "Normal" },
  { "TabLine", inherit = "StatusLine", fg = c.oldWhite },
  { "TabLineFill", link = "TabLine" },
  { "TabLineSel", link = "Normal" },
  { "VertSplit", fg = hi.bg("StatusLine") },
  { "WinSeparator", link = "VertSplit" },

  -- plugin
  { "HopNextKey", fg = c.peachRed, bold = true },
  { "HopNextKey1", fg = c.springGreen, bold = true },
  { "HopNextKey2", fg = c.waveBlue2 },
  { "HopUnmatched", fg = c.sumiInk4, special = c.sumiInk4 },
  { "InclineNormal", link = "StatusLine" },
  { "InclineNormalNC", inherit = "StatusLineNC", fg = hi.fg("NonText") },
  { "LTSymbolDetail", link = "Comment" },
  { "LTSymbolJump", link = "LspReferenceText" },
  { "ModesCopy", bg = hi.bg("IncSearch") },
  { "ModesDelete", bg = c.autumnRed },
  { "ModesInsert", bg = c.fujiWhite },
  { "ModesVisual", bg = c.oniViolet },
  { "NotifyTRACEBorder", link = "DiagnosticHint" },
  { "NotifyTRACETitle", link = "NotifyTRACEBorder" },
  { "NotifyTRACEIcon", link = "NotifyTRACEBorder" },
  { "NotifyDEBUGBorder", fg = c.fujiGray },
  { "NotifyDEBUGTitle", link = "NotifyDEBUGBorder" },
  { "NotifyDEBUGIcon", link = "NotifyDEBUGBorder" },
  { "NotifyINFOBorder", link = "DiagnosticInfo" },
  { "NotifyINFOTitle", link = "NotifyINFOBorder" },
  { "NotifyINFOIcon", link = "NotifyINFOBorder" },
  { "NotifyWARNBorder", link = "DiagnosticWarn" },
  { "NotifyWARNTitle", link = "NotifyWARNBorder" },
  { "NotifyWARNIcon", link = "NotifyWARNBorder" },
  { "NotifyERRORBorder", link = "DiagnosticError" },
  { "NotifyERRORTitle", link = "NotifyERRORBorder" },
  { "NotifyERRORIcon", link = "NotifyERRORBorder" },
  { "StatusLineGitBranch", inherit = "StatusLine", fg = c.springViolet1 },
  { "StatusLineModified", inherit = "StatusLine", fg = c.autumnRed },
  { "StatusLinePath", inherit = "StatusLine", fg = hi.fg("Comment") },
  { "StatusLineRO", inherit = "StatusLine", fg = c.samuraiRed },
  { "StatusLineMNormal", fg = c.crystalBlue },
  { "StatusLineMInsert", fg = c.autumnGreen },
  { "StatusLineMVisual", fg = c.oniViolet },
  { "StatusLineMReplace", fg = c.autumnRed },
  { "StatusLineMCommand", fg = c.boatYellow2 },
  { "TabLineModified", inherit = "TabLine", fg = c.autumnRed },
  { "TabLineSep", link = "TabLine" },
  { "TabLineModifiedSel", inherit = "TabLineSel", fg = c.autumnRed },
  { "TabLineSepSel", inherit = "TabLineSel", fg = c.crystalBlue },
  { "TreesitterContext", bg = hi.bg("StatusLine") },
})
