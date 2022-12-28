local function get_variant()
  local variants = {
    lighter = "lighter",
    darker = "darker",
    ["deep ocean"] = "deep ocean",
    oceanic = "oceanic",
    palenight = "palenight",
  }

  return variants[os.getenv("NVIM_MATERIAL_VARIANT")] or "deep ocean"
end

vim.g.material_style = get_variant()
require("material").setup({
  contrast = {
    sidebar = true,
    floating_windows = true,
    popup_menu = true,
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

vim.cmd.colorscheme("material")

local c = require("material.colors")

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend

  -- highlight-default
  set("ColorColumn", { bg = blend(c.editor.bg_alt, c.editor.bg, 0.3) })
  set("CursorColumn", { bg = blend(c.editor.highlight, c.editor.bg, 0.3) })
  link("CursorLine", "CursorColumn")
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("MatchParen", "LspReferenceText")
  set("StatusLine", { fg = c.editor.fg_dark, bg = c.editor.bg_alt })
  link("TabLine", "StatusLine")
  link("TablineFill", "TabLine")
  set("TabLineSel", { inherit = "Normal", fg = c.editor.accent })
  set("VertSplit", { fg = bg("StatusLine"), cterm = { reverse = true } })
  link("WinSeparator", "VertSplit")

  -- lsp-highlight
  set("LspSignatureActiveParameter", { fg = c.editor.accent })

  -- treesitter-highlight-groups
  link("@text.diff.add", "diffAdded")
  link("@text.diff.delete", "diffRemoved")

  -- plugin
  link("CmpCursorLine", "CursorLine")
  link("FloatTitle", "Title")
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("NonText") })
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineTail", { fg = c.editor.line_numbers, bold = true })
  set("InclineWinNr", {
    fg = fg("CursorLineNr"),
    bg = blend(fg("CursorLineNr"), bg("StatusLine"), 0.1),
  })
  local p = { "purple", "cyan", "darkgreen", "yellow", "darkpurple", "gray" }
  for i, v in ipairs(p) do
    local group = ("HeadLine%d"):format(i)
    set(group, { fg = c.main[v], bg = blend(c.main[v], c.editor.bg, 0.05) })
  end
  set("LTSymbol", { fg = c.main.paleblue })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  link("LTBoolean", "@boolean")
  link("LTConstant", "@constant")
  link("LTConstructor", "@constructor")
  link("LTField", "@field")
  link("LTFunction", "@function")
  link("LTMethod", "@method")
  link("LTNamespace", "@namespace")
  link("LTNumber", "@number")
  link("LTOperator", "@operator")
  link("LTParameter", "@parameter")
  link("LTParameterReference", "@parameter.reference")
  link("LTString", "@string")
  link("LTType", "@type")
  link("LTURI", "@text.uri")
  set("ModesCopy", { bg = c.main.darkyellow })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = c.main.red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = c.main.darkgreen })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = c.main.purple })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })
  link("NotifyTRACEBorder", "DiagnosticHint")
  link("NotifyTRACETitle", "NotifyTRACEBorder")
  link("NotifyTRACEIcon", "NotifyTRACEBorder")
  set("NotifyDEBUGBorder", { fg = c.main.paleblue })
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
  set("StatusLineDim", { inherit = "StatusLine", fg = c.editor.line_numbers })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.main.purple })
  set("StatusLineGitDiffAdd", { inherit = "StatusLine", fg = c.main.green })
  set("StatusLineGitDiffChange", { inherit = "StatusLine", fg = c.main.blue })
  set("StatusLineGitDiffDelete", { inherit = "StatusLine", fg = c.main.red })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.main.red })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.main.darkred })
  set("StatusLineMNormal", { fg = c.editor.accent })
  set("StatusLineMInsert", { fg = c.main.green })
  set("StatusLineMVisual", { fg = c.main.purple })
  set("StatusLineMReplace", { fg = c.main.red })
  set("StatusLineMCommand", { fg = c.main.yellow })
  set("TabLineModified", { inherit = "TabLine", fg = c.main.red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.main.red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.editor.accent })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  link("TelescopePreviewLine", "CursorLine")
  link("TelescopeSelection", "CursorLine")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  link("TelescopePromptBorder", "TelescopeBorder")
  link("TelescopePreviewBorder", "TelescopeBorder")
  link("TelescopeResultsBorder", "TelescopeBorder")
  set("TodoLink", { fg = c.main.paleblue })
  set("TodoTest", { fg = c.main.darkpurple })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = c.editor.fg,
  })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
