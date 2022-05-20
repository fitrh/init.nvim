local config = {}
config.dark_variant = "main"
config.disable_italics = true

local theme = require("rose-pine")
theme.setup(config)
theme.colorscheme()

local hi = require("sugar.highlight")
local c = require("rose-pine.palette")

hi.colorscheme({
  -- syntax, SEE: :help W18
  { "Comment", inherit = "Comment", italic = true },

  -- highlight-default
  { "ColorColumn", link = "StatusLine" },
  { "NormalFloat", link = "Normal" },
  { "TabLineSel", fg = c.text, bg = c.base },
  { "VertSplit", fg = hi.bg("StatusLine"), cterm = { reverse = true } },

  -- health
  { "healthError", link = "DiagnosticError" },
  { "healthSuccess", fg = c.pine },
  { "healthWarning", link = "DiagnosticWarn" },

  -- treesitter
  { "TSParameter", inherit = "TSParameter", italic = true },
  { "TSKeyword", inherit = "TSKeyword", italic = true },

  -- plugin
  { "HopNextKey", fg = c.love, bold = true },
  { "HopNextKey1", fg = c.gold, bold = true },
  { "HopNextKey2", fg = c.pine },
  { "HopUnmatched", fg = c.muted, special = c.muted },
  { "InclineNormal", link = "StatusLine" },
  { "InclineNormalNC", inherit = "StatusLine", fg = hi.fg("NonText") },
  { "LTSymbolDetail", link = "Comment" },
  { "LTSymbolJump", link = "LspReferenceText" },
  { "StatusLineGitBranch", inherit = "StatusLine", fg = c.iris },
  { "StatusLineModified", inherit = "StatusLine", fg = c.love },
  { "StatusLinePath", inherit = "StatusLine", fg = hi.fg("Comment") },
  { "StatusLineRO", inherit = "StatusLine", fg = c.love },
  { "StatusLineMNormal", fg = c.rose },
  { "StatusLineMInsert", fg = c.foam },
  { "StatusLineMVisual", fg = c.iris },
  { "StatusLineMReplace", fg = c.pine },
  { "StatusLineMCommand", fg = c.love },
  { "TreesitterContext", link = "LspReferenceText" },
})
