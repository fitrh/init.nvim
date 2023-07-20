local function get_variant()
  local variants = { wave = "wave", dragon = "dragon", lotus = "lotus" }
  return variants[os.getenv("NVIM_KANAGAWA_VARIANT")] or "wave"
end

local function get_mode()
  local modes = { dark = "wave", light = "lotus" }
  return modes[os.getenv("NVIM_KANAGAWA_MODE")] or "wave"
end

local config = {
  theme = get_mode() == "lotus" and "lotus" or get_variant(),
}

local background = config.theme == "lotus" and "light" or "dark"
vim.api.nvim_set_option_value("background", background, {})
local kanagawa = require("kanagawa")
kanagawa.setup(config)
kanagawa.load(config.theme)

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local fmt = string.format

  local base = bg("Normal")
  ---@type ThemeColors
  local c = require("kanagawa.colors").setup(config).theme

  -- highlight-default
  set("ColorColumn", { bg = blend(bg("StatusLine"), base, 0.3) })
  set("CursorColumn", { bg = blend(bg("CursorLine"), base, 0.3) })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { inherit = "CursorLineNr", bg = "NONE", bold = false })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  set("Folded", { inherit = "Folded", bg = "NONE" })
  set("LineNr", { inherit = "LineNr", bg = "NONE" })
  link("MatchParen", "LspReferenceText")
  link("MsgArea", "StatusLine")
  set("NonText", { inherit = "NonText", bold = false })
  link("TabLine", "StatusLine")
  link("TabLineFill", "TabLine")
  link("TabLineSel", "Normal")

  -- treesitter-highlight-groups
  link("@text.diff.add", "diffAdded")
  link("@text.diff.delete", "diffRemoved")

  -- plugin
  link("CmpCursorLine", "PmenuSel")
  set("CmpDoc", { inherit = "PmenuSel", blend = 0 })
  link("FloatTitle", "Title")
  set("HopNextKey", { fg = c.syn.special3, bold = true })
  set("HopNextKey1", { fg = c.syn.string, bold = true })
  set("HopNextKey2", { fg = c.ui.bg_search })
  set("HopUnmatched", { fg = c.ui.nontext, special = c.ui.nontext })
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLineNC", fg = c.ui.whitespace })
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineTail", { fg = c.ui.special, bold = true })
  local fg_cul_nr = fg("CursorLineNr")
  set("InclineWinNr", {
    fg = fg_cul_nr,
    bg = blend(fg_cul_nr, bg("StatusLine"), 0.1),
  })
  set("LTSymbol", { fg = c.ui.fg_dim })
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
  set("ModesCopy", { bg = bg("IncSearch") })
  set("ModesDelete", { bg = c.vcs.removed })
  set("ModesInsert", { bg = c.vcs.added })
  set("ModesVisual", { bg = c.syn.statement })
  for _, v in ipairs({ "Copy", "Delete", "Insert", "Visual" }) do
    local def = { inherit = "CursorLineNr", fg = bg(concat({ "Modes", v })) }
    set(concat({ "Modes", v, "CursorLineNr" }), def)
  end

  --- github.com/rcarriga/nvim-notify
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local title = fmt("Notify%sTitle", v)
    local color = blend(fg(title), base, 0.05)
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
  end

  set("StatusLineDim", { inherit = "StatusLine", fg = c.ui.nontext })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.ui.special })
  set("StatusLineGitDiffAdd", { inherit = "StatusLine", fg = c.vcs.added })
  set("StatusLineGitDiffChange", { inherit = "StatusLine", fg = c.vcs.changed })
  set("StatusLineGitDiffDelete", { inherit = "StatusLine", fg = c.vcs.removed })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.vcs.removed })
  set("StatusLinePath", { inherit = "StatusLine", fg = c.diff.text })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.diag.error })
  set("TabLineModified", { inherit = "TabLine", fg = c.vcs.added })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.vcs.added })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.syn.fun })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  link("TelescopePreviewLine", "CursorLine")
  link("TelescopeSelection", "CursorLine")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = c.ui.fg,
  })
  set("WinSeparatorZen", { fg = base })
end)
