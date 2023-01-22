local function get_mode()
  local modes = { dark = "default", light = "light" }
  return modes[os.getenv("NVIM_KANAGAWA_MODE")] or "default"
end

local config = {}

config.globalStatus = true
config.theme = get_mode()

require("kanagawa").setup(config)

vim.cmd.colorscheme("kanagawa")

---@type KanagawaColors|ThemeColors
local c = require("kanagawa.colors").setup(config)

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local fmt = string.format

  local base = bg("Normal")

  -- highlight-default
  set("ColorColumn", { bg = blend(bg("StatusLine"), bg("Normal"), 0.3) })
  set("CursorColumn", { bg = blend(bg("CursorLine"), bg("Normal"), 0.2) })
  link("CursorLine", "CursorColumn")
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  set("Folded", { inherit = "Folded", bg = "NONE" })
  link("MatchParen", "LspReferenceText")
  link("MsgArea", "StatusLine")
  set("NonText", { inherit = "NonText", bold = false })
  set("TabLine", { inherit = "StatusLine", fg = c.fujiGray })
  link("TabLineFill", "TabLine")
  link("TabLineSel", "Normal")
  set("VertSplit", { fg = bg("StatusLine") })
  link("WinSeparator", "VertSplit")

  -- treesitter-highlight-groups
  link("@text.diff.add", "diffAdded")
  link("@text.diff.delete", "diffRemoved")

  -- plugin
  link("CmpCursorLine", "PmenuSel")
  set("CmpDoc", { inherit = "PmenuSel", blend = 0 })
  link("FloatTitle", "Title")
  for i, p in ipairs({
    "springViolet1",
    "autumnGreen",
    "waveAqua1",
    "boatYellow2",
    "oniViolet",
    "waveAqua2",
  }) do
    set(("HeadLine%d"):format(i), { fg = c[p], bg = blend(c[p], c.bg, 0.05) })
  end
  set("HopNextKey", { fg = c.peachRed, bold = true })
  set("HopNextKey1", { fg = c.springGreen, bold = true })
  set("HopNextKey2", { fg = c.waveBlue2 })
  set("HopUnmatched", { fg = c.sumiInk4, special = c.sumiInk4 })
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLineNC", fg = c.sumiInk4 })
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineTail", { fg = c.springViolet1, bold = true })
  set("InclineWinNr", {
    fg = fg("CursorLineNr"),
    bg = blend(fg("CursorLineNr"), bg("StatusLine"), 0.1),
  })
  set("LTSymbol", { fg = c.oldWhite })
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
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = c.autumnRed })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = c.autumnGreen })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = c.oniViolet })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })

  --- github.com/rcarriga/nvim-notify
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local title = fmt("Notify%sTitle", v)
    local color = blend(fg(title), base, 0.05)
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
  end

  set("StatusLineDim", { inherit = "StatusLine", fg = c.boatYellow1 })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.springViolet1 })
  set("StatusLineGitDiffAdd", { inherit = "StatusLine", fg = c.git.added })
  set("StatusLineGitDiffChange", { inherit = "StatusLine", fg = c.git.changed })
  set("StatusLineGitDiffDelete", { inherit = "StatusLine", fg = c.git.removed })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.autumnRed })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.samuraiRed })
  for k, v in pairs({
    Normal = c.crystalBlue,
    Insert = c.autumnGreen,
    Visual = c.oniViolet,
    Replace = c.autumnRed,
    Command = c.boatYellow2,
  }) do
    local def = { inherit = "StatusLine", fg = v, bold = true }
    set(fmt("StatusLineM%s", k), def)
  end
  set("TabLineModified", { inherit = "TabLine", fg = c.autumnRed })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.autumnRed })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.crystalBlue })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  link("TelescopePreviewLine", "CursorLine")
  link("TelescopeSelection", "CursorLine")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  set("TodoLink", { fg = c.bg_visual })
  set("TodoTest", { fg = c.springViolet2 })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = c.fg,
  })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
