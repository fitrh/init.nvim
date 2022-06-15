local config = {}
config.dark_variant = "main"
config.disable_italics = true

local theme = require("rose-pine")
theme.setup(config)
theme.colorscheme()

local c = require("rose-pine.palette")

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend

  -- syntax, SEE: :help W18
  set("Comment", { inherit = "Comment", italic = true })

  -- highlight-default
  link("ColorColumn", "StatusLine")
  link("NormalFloat", "Normal")
  link("TabLineSel", "Normal")
  set("VertSplit", { fg = bg("StatusLine"), cterm = { reverse = true } })

  -- health
  link("healthError", "DiagnosticError")
  set("healthSuccess", { fg = c.pine })
  link("healthWarning", "DiagnosticWarn")

  -- treesitter
  set("TSParameter", { inherit = "TSParameter", italic = true })
  set("TSKeyword", { inherit = "TSKeyword", italic = true })

  -- plugin
  link("CmpDocumentationBorder", "LineNr")
  set("HopNextKey", { fg = c.love, bold = true })
  set("HopNextKey1", { fg = c.gold, bold = true })
  set("HopNextKey2", { fg = c.pine })
  set("HopUnmatched", { fg = c.muted, special = c.muted })
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("NonText") })
  set("InclineWinNr", {
    fg = fg("CursorLineNr"),
    bg = blend(fg("CursorLineNr"), bg("StatusLine"), 0.1),
  })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.iris })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.love })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.love })
  set("StatusLineMNormal", { fg = c.rose })
  set("StatusLineMInsert", { fg = c.foam })
  set("StatusLineMVisual", { fg = c.iris })
  set("StatusLineMReplace", { fg = c.pine })
  set("StatusLineMCommand", { fg = c.love })
  set("TabLineModified", { inherit = "TabLine", fg = c.love })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.love })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.rose })
  set("TreesitterContext", { bg = bg("StatusLine") })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
