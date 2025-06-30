local function get_mode()
  local modes = { dark = "dark", light = "light" }
  return modes[os.getenv("NVIM_ROSE_PINE_MODE")]
end

local function get_variant()
  local variants = { main = "main", moon = "moon", dawn = "dawn" }
  return variants[os.getenv("NVIM_ROSE_PINE_VARIANT")] or "main"
end

local mode = get_mode()
if mode and mode == "dark" or mode == "light" then
  vim.api.nvim_set_option_value("background", mode, {})
end

local config = {}
config.dark_variant = get_variant()
config.styles = {
  italic = false,
}

local theme = require("rose-pine")
theme.setup(config)
theme.colorscheme()

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local concat = table.concat
  local fmt = string.format

  local background = vim.api.nvim_get_option_value("background", {})
  local function lightdark(light, dark)
    return background == "light" and light or dark
  end
  local c = require("rose-pine.palette")

  -- syntax, SEE: :help W18
  set("Comment", { inherit = "Comment", italic = true })

  -- highlight-default
  set("ColorColumn", {
    bg = blend(bg("StatusLine"), c.base, lightdark(0.8, 0.4)),
  })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("Folded", "LineNr")
  link("MsgArea", "StatusLine")
  set("StatusLineNC", {
    fg = lightdark(c.muted, c.highlight_med),
    bg = c.surface,
  })
  link("TabLineSel", "Normal")

  -- h: diagnostic-highlights
  set("DiagnosticUnnecessary", { fg = c.subtle })

  -- health
  link("healthError", "DiagnosticError")
  set("healthSuccess", { fg = c.pine })
  link("healthWarning", "DiagnosticWarn")

  -- treesitter
  set("@keyword", { inherit = "@keyword", italic = true })
  link("@diff.plus", "GitSignsAdd")
  link("@diff.minus", "GitSignsDelete")

  -- :h lsp-semantic-highlight
  link("@lsp.typemod.function.defaultLibrary", "@function.builtin")

  -- plugin
  set("CmpCursorLine", { bg = bg("PmenuSel") })
  set("CmpDoc", { inherit = "PmenuSel", blend = 0 })
  link("FloatTitle", "Title")
  set("HopNextKey", { fg = c.love, bold = true })
  set("HopNextKey1", { fg = c.gold, bold = true })
  set("HopNextKey2", { fg = c.pine })
  set("HopUnmatched", { fg = c.muted, special = c.muted })
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("NonText") })
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineTail", { fg = c.subtle, bold = true })
  set("InclineWinNr", {
    fg = fg("CursorLineNr"),
    bg = blend(fg("CursorLineNr"), bg("StatusLine"), 0.1),
  })
  set("LTSymbol", { fg = c.iris })
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
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })

  --- github.com/rcarriga/nvim-notify
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local border = fmt("Notify%sBorder", v)
    local title = fmt("Notify%sTitle", v)
    local color = blend(fg(border), c.base, lightdark(0.1, 0.05))
    set(title, { inherit = border, bg = color })
    link(fmt("Notify%sIcon", v), title)
    link(fmt("Notify%sBody", v), title)
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
  end

  for _, severity in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    local count = concat({ "StatusLineDiagnostic", severity, "Count" })
    local sign = concat({ "StatusLineDiagnostic", severity, "Sign" })
    local sign_hl = concat({ "Diagnostic", "Sign", severity })
    set(count, { inherit = "StatusLine", fg = fg(sign_hl) })
    set(sign, {
      inherit = "StatusLine",
      fg = blend(fg(sign_hl), bg("StatusLine"), 0.7),
    })
  end
  set("StatusLineDim", { inherit = "StatusLine", fg = c.muted })
  set("StatusLineFilename", { inherit = "StatusLine", bold = true })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.iris })
  set("StatusLineGitDiffAdd", { inherit = "StatusLine", fg = c.foam })
  set("StatusLineGitDiffChange", { inherit = "StatusLine", fg = c.rose })
  set("StatusLineGitDiffDelete", { inherit = "StatusLine", fg = c.love })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.love })
  set("StatusLinePath", {
    inherit = "StatusLine",
    fg = lightdark(c.muted, c.highlight_high),
  })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.love })
  set("TabLineModified", { inherit = "TabLine", fg = c.love })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.love })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.rose })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  link("TelescopePreviewLine", "TelescopeSelection")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopePromptNormal", { bg = bg("StatusLine") })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = c.text,
  })
  set("WinSeparatorZen", { fg = c.base })
end)
