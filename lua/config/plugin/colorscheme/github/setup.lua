local config = {}

config.theme_style = "dark_default"

require("github-theme").setup(config)

local p = require("github-theme.palette").get_palette(config.theme_style)

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend

  -- highlight-default
  set("ColorColumn", { bg = blend(p.bg2, p.bg, 0.4) })
  set("CursorColumn", { bg = blend(p.bright_blue, p.bg, 0.03) })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { fg = p.bright_blue })
  link("Folded", "LineNr")
  set("NonText", { fg = p.fg_dark })
  set("StatusLine", { bg = p.bg2, fg = p.fg })
  link("TabLineSel", "Normal")
  set("TabLine", { inherit = "StatusLine", fg = p.fg_dark })
  link("TabLineFill", "TabLine")
  set("VertSplit", { fg = p.bg2 })

  -- plugin
  set("CmpCursorLine", { bg = blend(p.cursor, p.pmenu.bg, 0.05) })
  link("CmpDocumentationBorder", "LineNr")
  set("FidgetTask", { inherit = "Comment", italic = false })
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("Comment") })
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineWinNr", {
    fg = p.bright_blue,
    bg = blend(p.bright_blue, p.bg2, 0.1),
  })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("ModesCopy", { bg = p.warning })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = p.red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = p.green })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = p.bright_magenta })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = p.magenta })
  set("StatusLineModified", { inherit = "StatusLine", fg = p.bright_red })
  set("StatusLinePath", { inherit = "StatusLine", fg = p.black })
  set("StatusLinePathSep", {
    inherit = "StatusLine",
    fg = p.fg_dark,
    bold = true,
  })
  set("StatusLineRO", { inherit = "StatusLine", fg = p.red })
  set("StatusLineMNormal", { fg = p.bright_blue })
  set("StatusLineMInsert", { fg = p.green })
  set("StatusLineMVisual", { fg = p.bright_magenta })
  set("StatusLineMReplace", { fg = p.red })
  set("StatusLineMCommand", { fg = p.yellow })
  set("TabLineModified", { inherit = "TabLine", fg = p.red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = p.red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = p.bright_blue })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  set("TreesitterContext", { inherit = "TreesitterContext", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = fg("LineNr"),
  })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
