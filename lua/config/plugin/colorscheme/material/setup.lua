vim.g.material_style = "deep ocean" -- deep ocean, oceanic, palenight, darker

require("material").setup({
  contrast = {
    sidebar = true,
  },
  italics = {
    comments = true,
    keywords = true,
  },
  async_loading = false,
  disable = {
    colored_cursor = true,
  },
})

vim.cmd([[colorscheme material]])

local c = require("material.colors")

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend

  -- highlight-default
  set("ColorColumn", { bg = blend(c.bg_alt, c.bg, 0.3) })
  set("CursorColumn", { bg = blend(c.highlight, c.bg, 0.3) })
  link("CursorLine", "CursorColumn")
  set("StatusLine", { fg = c.text, bg = c.bg_alt })
  link("TabLine", "StatusLine")
  link("TablineFill", "TabLine")
  set("TabLineSel", { inherit = "Normal", fg = c.accent })
  set("VertSplit", { fg = bg("StatusLine"), cterm = { reverse = true } })
  link("WinSeparator", "VertSplit")

  -- lsp-highlight
  set("LspSignatureActiveParameter", { fg = c.accent })

  -- plugin
  link("CmpCursorLine", "CursorLine")
  link("CmpDocumentationBorder", "LineNr")
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("NonText") })
  set("InclineWinNr", {
    fg = fg("CursorLineNr"),
    bg = blend(fg("CursorLineNr"), bg("StatusLine"), 0.1),
  })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("ModesCopy", { bg = c.darkyellow })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = c.red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = c.darkgreen })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = c.purple })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })
  link("NotifyTRACEBorder", "DiagnosticHint")
  link("NotifyTRACETitle", "NotifyTRACEBorder")
  link("NotifyTRACEIcon", "NotifyTRACEBorder")
  set("NotifyDEBUGBorder", { fg = c.paleblue })
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
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.purple })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.red })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLinePathSep", { inherit = "StatusLine", fg = c.text, bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.darkred })
  set("StatusLineMNormal", { fg = c.accent })
  set("StatusLineMInsert", { fg = c.green })
  set("StatusLineMVisual", { fg = c.purple })
  set("StatusLineMReplace", { fg = c.red })
  set("StatusLineMCommand", { fg = c.yellow })
  set("TabLineModified", { inherit = "TabLine", fg = c.red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.accent })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  link("TelescopePromptBorder", "TelescopeBorder")
  link("TelescopePreviewBorder", "TelescopeBorder")
  link("TelescopeResultsBorder", "TelescopeBorder")
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = fg("LineNr"),
  })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
