local function get_mode()
  local modes = { dark = "dark", light = "light" }
  return modes[os.getenv("NVIM_GRUVBOX_MODE")] or "dark"
end

local function get_variant()
  local variants = { soft = "soft", hard = "hard" }
  return variants[os.getenv("NVIM_GRUVBOX_VARIANT")] or ""
end

vim.api.nvim_set_option("background", get_mode())
local gruvbox = require("gruvbox")
gruvbox.setup({ contrast = get_variant() })
gruvbox.load()

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local c = require("gruvbox.palette")

  -- highlight-default
  set("ColorColumn", { bg = blend(bg("ColorColumn"), bg("Normal"), 0.1) })
  set("CursorColumn", { bg = blend(bg("CursorLine"), bg("Normal"), 0.3) })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { fg = c.bright_yellow })
  set("DiagnosticSignInfo", { inherit = "DiagnosticSignInfo", bg = "NONE" })
  set("DiagnosticSignWarn", { inherit = "DiagnosticSignWarn", bg = "NONE" })
  set("DiagnosticSignHint", { inherit = "DiagnosticSignHint", bg = "NONE" })
  set("DiagnosticSignError", { inherit = "DiagnosticSignError", bg = "NONE" })
  set("DiffAdd", { inherit = "DiffAdd", reverse = false })
  set("DiffChange", { inherit = "DiffChange", reverse = false })
  set("DiffDelete", { inherit = "DiffDelete", reverse = false })
  set("DiffText", { inherit = "DiffText", reverse = false })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  set("Folded", { inherit = "Folded", bg = "NONE" })
  set("LineNr", { fg = c.light3 })
  link("SignColumn", "LineNr")
  set("StatusLine", { bg = c.dark1, fg = c.light2 })
  set("TabLineSel", { inherit = "TabLineSel", bg = bg("Normal") })
  set("VertSplit", { fg = bg("StatusLine") })

  -- health
  link("healthError", "DiagnosticError")
  set("healthSuccess", { fg = c.bright_green })
  link("healthWarning", "DiagnosticWarn")

  -- plugin
  link("CmpCursorLine", "Visual")
  link("FloatTitle", "Title")
  set("GitSignsAdd", { inherit = "GitSignsAdd", bg = "NONE" })
  set("GitSignsChange", { inherit = "GitSignsChange", bg = "NONE" })
  set("GitSignsDelete", { inherit = "GitSignsDelete", bg = "NONE" })
  for i, p in ipairs({
    "bright_purple",
    "bright_aqua",
    "bright_blue",
    "neutral_yellow",
    "neutral_green",
    "neutral_purple",
  }) do
    set(("HeadLine%s"):format(i), {
      fg = c[p],
      bg = blend(c[p], bg("Normal"), 0.05),
    })
  end
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("Comment") })
  set("InclineSep", { fg = fg("Comment"), bold = true })
  set("InclineWinNr", {
    fg = c.bright_yellow,
    bg = blend(c.bright_yellow, bg("StatusLine"), 0.1),
  })
  link("LspSignatureActiveParameter", "GruvboxYellow")
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("ModesCopy", { bg = fg("IncSearch") })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = c.bright_red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = c.bright_blue })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = c.bright_purple })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })
  link("NotifyTRACEBorder", "DiagnosticHint")
  link("NotifyTRACETitle", "NotifyTRACEBorder")
  link("NotifyTRACEIcon", "NotifyTRACEBorder")
  set("NotifyDEBUGBorder", { fg = c.gray })
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
  set("StatusLineDim", { inherit = "StatusLine", fg = c.light4 })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.bright_purple })
  for _, kind in ipairs({ "Add", "Change", "Delete" }) do
    local group = ("StatusLineGitDiff%s"):format(kind)
    set(group, { inherit = "StatusLine", fg = fg(("GitSigns%s"):format(kind)) })
  end
  set("StatusLineModified", { inherit = "StatusLine", fg = c.bright_red })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.faded_red })
  set("StatusLineMNormal", { fg = c.bright_yellow })
  set("StatusLineMInsert", { fg = c.bright_blue })
  set("StatusLineMVisual", { fg = c.bright_orange })
  set("StatusLineMReplace", { fg = c.bright_aqua })
  set("StatusLineMCommand", { fg = c.bright_red })
  set("TabLineModified", { inherit = "TabLine", fg = c.bright_red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.bright_red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.bright_blue })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  link("TelescopePreviewLine", "CursorLine")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  link("TelescopePromptBorder", "TelescopeBorder")
  link("TelescopePromptCounter", "StatusLine")
  link("TelescopePreviewBorder", "TelescopeBorder")
  link("TelescopeResultsBorder", "TelescopeBorder")
  set("TodoLink", { fg = c.neutral_blue })
  set("TodoTest", { fg = c.neutral_aqua })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = fg("Normal"),
  })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
