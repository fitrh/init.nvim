local function get_variant()
  local variants = {
    storm = "storm",
    night = "night",
    moon = "moon",
    day = "day",
  }
  return variants[os.getenv("NVIM_TOKYONIGHT_VARIANT")] or "night"
end

local function get_mode()
  local modes = { dark = "dark", light = "light" }
  return modes[os.getenv("NVIM_TOKYONIGHT_MODE")] or "dark"
end

local config = {}
config.style = get_variant()
config.sidebars = { "qf" }
vim.api.nvim_set_option("background", get_mode())
require("tokyonight").load(config)

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local fmt = string.format
  local c = require("tokyonight.colors").setup(config)
  local util = require("tokyonight.util")

  if get_mode() == "light" or get_variant() == "day" then
    for key, value in pairs(c) do
      c[key] = util.invert_colors(value)
    end
  end

  local br_red = util.lighten(c.red, 0.2, c.red)
  local base = bg("Normal")
  local bg_statusline = bg("StatusLine")

  -- highlight-default
  set("ColorColumn", { bg = blend(bg_statusline, base, 0.4) })
  set("CursorColumn", { bg = blend(c.blue, base, 0.05) })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { fg = c.blue })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("Folded", "LineNr")
  link("MatchParen", "LspReferenceText")
  link("MsgArea", "StatusLine")
  set("StatusLine", { inherit = "StatusLine", fg = c.dark5 })
  link("TabLine", "StatusLineNC")
  link("TabLineFill", "TabLine")
  link("TabLineSel", "Normal")
  set("VertSplit", { fg = c.bg_highlight })
  link("WinSeparator", "VertSplit")

  -- treesitter
  set("@constant.builtin.dart", { fg = c.red })
  link("@text.diff.add", "diffAdded")
  link("@text.diff.delete", "diffRemoved")
  set("@text.literal.markdown_inline", {
    fg = c.fg_dark,
    bg = blend(c.fg_dark, c.bg, 0.05),
  })
  set("@text.todo.unchecked", { inherit = "@text.todo.unchecked", bold = true })
  set("@namespace", { fg = c.magenta })

  -- plugin
  link("CmpCursorLine", "PmenuSel")
  set("CmpDoc", { inherit = "PmenuSel", blend = 0 })
  set("CmpItemKindFile", { fg = c.fg_dark })
  link("InclineNormal", "StatusLine")
  link("InclineNormalNC", "StatusLineNC")
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineTail", { fg = c.dark3, bold = true })
  set("InclineWinNr", { fg = c.blue, bg = blend(c.blue, bg_statusline, 0.1) })
  set("LTSymbol", { fg = c.fg_dark })
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
  set("ModesDelete", { bg = c.red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = c.green })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = c.purple })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })

  --- github.com/rcarriga/nvim-notify
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local title = fmt("Notify%sTitle", v)
    local color = blend(fg(title), base, 0.05)
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
  end

  set("StatusLineDim", { inherit = "StatusLine", fg = c.dark3 })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.purple })
  for _, kind in ipairs({ "Add", "Change", "Delete" }) do
    local group = ("StatusLineGitDiff%s"):format(kind)
    set(group, { inherit = "StatusLine", fg = c.gitSigns[kind:lower()] })
  end
  set("StatusLineModified", { inherit = "StatusLine", fg = br_red })
  link("StatusLinePath", "StatusLineNC")
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.red1 })
  set("TabLineModified", { inherit = "TabLine", fg = br_red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = br_red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.blue })
  set("TelescopeNormal", { bg = bg_statusline })
  link("TelescopePreviewLine", "CursorLine")
  link("TelescopeSelection", "CursorLine")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg_statusline, fg = bg_statusline })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = c.fg_dark,
  })
  set("WinSeparatorZen", { fg = base })
end)
