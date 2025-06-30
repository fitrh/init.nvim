local env = os.getenv
-- SEE: https://github.com/folke/tokyonight.nvim/pull/548
local function get_variant()
  local variants = {
    storm = "storm",
    night = "night",
    dark = "night",
    moon = "moon",
    day = "day",
    light = "day",
  }
  return variants[env("NVIM_TOKYONIGHT_VARIANT") or env("NVIM_BACKGROUND") or vim.api.nvim_get_option_value(
    "background",
    {}
  )]
end

local function get_mode()
  local modes = { dark = "dark", light = "light" }
  return modes[env("NVIM_TOKYONIGHT_MODE") or env("NVIM_BACKGROUND")]
end

local config = {}
config.style = get_variant()
config.sidebars = { "qf" }
local mode = get_mode()
if mode then
  vim.api.nvim_set_option_value("background", mode, {})
end
require("tokyonight").load(config)

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local fmt = string.format
  local concat = table.concat

  local background = vim.api.nvim_get_option_value("background", {})
  local function lightdark(light, dark)
    return background == "light" and light or dark
  end

  local c = require("tokyonight.colors").setup(config)
  local util = require("tokyonight.util")

  if background == "light" or config.style == "day" then
    for key, value in pairs(c) do
      c[key] = util.invert_colors(value)
    end
  end

  local br_red = util.lighten(c.red, 0.2, c.red)
  local base = bg("Normal")
  local bg_statusline = bg("StatusLine")

  -- highlight-default
  set("ColorColumn", { bg = blend(bg_statusline, base, lightdark(0.8, 0.4)) })
  set("CursorColumn", { bg = blend(c.blue, base, lightdark(0.15, 0.05)) })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { fg = c.blue })
  -- set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("Folded", "LineNr")
  link("MatchParen", "LspReferenceText")
  -- replaced by autocmd
  set("StatusLine", { inherit = "StatusLine", fg = c.dark5 })
  link("TabLine", "StatusLineNC")
  link("TabLineFill", "TabLine")
  link("TabLineSel", "Normal")
  set("VertSplit", { fg = c.bg_highlight })
  link("WinSeparator", "VertSplit")

  -- treesitter
  set("@constant.builtin.dart", { fg = c.red })
  link("@diff.plus", "diffAdded")
  link("@diff.minus", "diffRemoved")
  set("@markup.raw.markdown_inline", {
    fg = c.fg_dark,
    bg = blend(c.fg_dark, c.bg, lightdark(0.15, 0.05)),
  })
  set("@markup.list.unchecked", {
    inherit = "@markup.list.unchecked",
    bold = true,
  })
  set("@text.uri.comment", { inherit = "markdownLinkText", underdotted = true })
  set("@module", { fg = c.magenta })

  -- plugin
  link("CmpCursorLine", "PmenuSel")
  set("CmpDoc", { inherit = "PmenuSel", blend = 0 })
  set("CmpItemKindFile", { fg = c.fg_dark })
  link("InclineNormal", "StatusLine")
  link("InclineNormalNC", "StatusLineNC")
  set("InclineSep", { fg = fg("LineNr") })
  set("InclineTail", { fg = c.dark3, bold = true })
  set("InclineWinNr", {
    fg = c.blue,
    bg = blend(c.blue, bg_statusline, lightdark(0.2, 0.1)),
  })
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
    local color = blend(fg(title), base, lightdark(0.1, 0.05))
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
    link(concat({ "Notify", v, "Icon" }), title)
  end

  for _, severity in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    -- local group = concat({ "StatusLineDiagnostic", severity })
    local count = concat({ "StatusLineDiagnostic", severity, "Count" })
    local sign = concat({ "StatusLineDiagnostic", severity, "Sign" })
    local sign_hl = concat({ "Diagnostic", "Sign", severity })
    local sign_fg = blend(fg(sign_hl), bg("StatusLine"), 0.7)
    -- set(group, { inherit = "StatusLine", fg = fg(sign_hl) })
    set(count, { inherit = "StatusLine", fg = fg(sign_hl) })
    set(sign, { inherit = "StatusLine", fg = sign_fg })
  end
  set("StatusLineDim", { inherit = "StatusLine", fg = c.dark3 })
  set("StatusLineFilename", { inherit = "StatusLine", bold = true })
  -- set("StatusLineFilenameMod", { inherit = "StatusLineFilename", fg = br_red })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.purple })
  for _, kind in ipairs({ "Add", "Change", "Delete" }) do
    local group = ("StatusLineGitDiff%s"):format(kind)
    set(group, { inherit = "StatusLine", fg = c.git[kind:lower()] })
  end

  set("StatusLineModified", { inherit = "StatusLine", fg = br_red })
  link("StatusLinePath", "StatusLineNC")
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.red1 })
  set("StatusLineWinNr", { inherit = "StatusLineNC", fg = fg("Number") })
  set("TabLineModified", { inherit = "TabLine", fg = br_red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = br_red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.blue })
  set("TelescopeNormal", { bg = bg_statusline })
  link("TelescopePreviewLine", "CursorLine")
  link("TelescopeSelection", "CursorLine")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg_statusline, fg = bg_statusline })
  link("TreesitterContext", "Normal")
  set("TreesitterContextBottom", { sp = fg("LineNr"), underline = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = c.fg_dark,
  })
  set("WinSeparatorZen", { fg = base })
end)
