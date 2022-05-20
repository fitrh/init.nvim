local style = "hard"
vim.g.gruvbox_contrast_dark = style
require("gruvbox").load()

local c = require("gruvbox.colors")
local hi = require("sugar.highlight")
local bg = style == "medium" and c.dark0 or c["dark0_" .. style]

hi.colorscheme({
  -- highlight-default
  { "CursorLineNr", fg = c.bright_yellow },
  { "DiagnosticSignInfo", inherit = "DiagnosticSignInfo", bg = "NONE" },
  { "DiagnosticSignWarn", inherit = "DiagnosticSignWarn", bg = "NONE" },
  { "DiagnosticSignHint", inherit = "DiagnosticSignHint", bg = "NONE" },
  { "DiagnosticSignError", inherit = "DiagnosticSignError", bg = "NONE" },
  { "DiffAdd", inherit = "DiffAdd", reverse = false },
  { "DiffChange", inherit = "DiffChange", reverse = false },
  { "DiffDelete", inherit = "DiffDelete", reverse = false },
  { "DiffText", inherit = "DiffText", reverse = false },
  { "LineNr", fg = c.light3 },
  { "NormalFloat", link = "Normal" },
  { "SignColumn", link = "LineNr" },
  { "StatusLine", bg = c.dark1, fg = c.light2 },
  { "TabLineSel", inherit = "TabLineSel", bg = bg },
  { "VertSplit", fg = hi.bg("StatusLine"), cterm = { reverse = true } },

  -- health
  { "healthError", link = "DiagnosticError" },
  { "healthSuccess", fg = c.bright_green },
  { "healthWarning", link = "DiagnosticWarn" },

  -- plugin
  { "GitSignsAdd", inherit = "GitSignsAdd", bg = "NONE" },
  { "GitSignsAddLn", fg = hi.fg("DiffAdd"), reverse = true },
  { "GitSignsAddInline", fg = c.faded_green, bold = true, reverse = true },
  { "GitSignsChange", inherit = "GitSignsChange", bg = "NONE" },
  { "GitSignsChangeLn", fg = hi.fg("DiffChange"), reverse = true },
  { "GitSignsChangeInline", fg = c.faded_aqua, bold = true, reverse = true },
  { "GitSignsDelete", inherit = "GitSignsDelete", bg = "NONE" },
  { "GitSignsDeleteLn", fg = hi.fg("DiffDelete"), reverse = true },
  { "GitSignsDeleteInline", fg = c.faded_red, bold = true, reverse = true },
  { "InclineNormal", link = "StatusLine" },
  { "InclineNormalNC", inherit = "StatusLine", fg = hi.fg("Comment") },
  { "LTSymbolDetail", link = "Comment" },
  { "LTSymbolJump", link = "LspReferenceText" },
  { "ModesCopy", bg = hi.fg("IncSearch") },
  { "ModesDelete", bg = c.bright_red },
  { "ModesInsert", bg = c.bright_blue },
  { "ModesVisual", bg = c.bright_orange },
  { "NotifyTRACEBorder", link = "DiagnosticHint" },
  { "NotifyTRACETitle", link = "NotifyTRACEBorder" },
  { "NotifyTRACEIcon", link = "NotifyTRACEBorder" },
  { "NotifyDEBUGBorder", fg = c.gray },
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
  { "StatusLineGitBranch", inherit = "StatusLine", fg = c.bright_purple },
  { "StatusLineModified", inherit = "StatusLine", fg = c.bright_red },
  { "StatusLinePath", inherit = "StatusLine", fg = hi.fg("Comment") },
  { "StatusLineRO", inherit = "StatusLine", fg = c.faded_red },
  { "StatusLineMNormal", fg = c.bright_yellow },
  { "StatusLineMInsert", fg = c.bright_blue },
  { "StatusLineMVisual", fg = c.bright_orange },
  { "StatusLineMReplace", fg = c.bright_aqua },
  { "StatusLineMCommand", fg = c.bright_red },
  { "TreesitterContext", inherit = "LspReferenceText", underline = false },
})
