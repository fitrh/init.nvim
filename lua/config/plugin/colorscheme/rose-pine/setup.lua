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
  set("ColorColumn", { bg = blend(bg("StatusLine"), c.base, 0.4) })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("Folded", "LineNr")
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
  link("CmpCursorLine", "Visual")
  link("FloatTitle", "Title")
  for i, p in ipairs({ "iris", "foam", "gold", "rose", "pine" }) do
    set(("HeadLine%d"):format(i), { fg = c[p], bg = blend(c[p], c.base, 0.05) })
  end
  set("HopNextKey", { fg = c.love, bold = true })
  set("HopNextKey1", { fg = c.gold, bold = true })
  set("HopNextKey2", { fg = c.pine })
  set("HopUnmatched", { fg = c.muted, special = c.muted })
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("NonText") })
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineWinNr", {
    fg = fg("CursorLineNr"),
    bg = blend(fg("CursorLineNr"), bg("StatusLine"), 0.1),
  })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.iris })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.love })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLinePathSep", { inherit = "StatusLine", bold = true })
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
  set("TelescopeNormal", { bg = bg("StatusLine") })
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopePromptNormal", { bg = bg("StatusLine") })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = fg("LineNr"),
  })
  set("WinSeparatorZen", { fg = c.base })
end)
