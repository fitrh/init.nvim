local function get_mode()
  local modes = { dark = "dark", light = "light" }
  return modes[os.getenv("NVIM_ROSE_PINE_MODE")] or "dark"
end

local function get_variant()
  local variants = { main = "main", moon = "moon" }
  return variants[os.getenv("NVIM_ROSE_PINE_VARIANT")] or "main"
end

vim.api.nvim_set_option("background", get_mode())

local config = {}
config.dark_variant = get_variant()
config.disable_italics = true

local theme = require("rose-pine")
theme.setup(config)
theme.colorscheme()

local c = require("rose-pine.palette")

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local fmt = string.format

  -- syntax, SEE: :help W18
  set("Comment", { inherit = "Comment", italic = true })

  -- highlight-default
  set("ColorColumn", { bg = blend(bg("StatusLine"), c.base, 0.4) })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("Folded", "LineNr")
  set("StatusLineNC", { fg = c.highlight_med, bg = c.base })
  link("TabLineSel", "Normal")
  set("VertSplit", { fg = bg("StatusLine"), cterm = { reverse = true } })

  -- health
  link("healthError", "DiagnosticError")
  set("healthSuccess", { fg = c.pine })
  link("healthWarning", "DiagnosticWarn")

  -- treesitter
  set("@keyword", { inherit = "@keyword", italic = true })
  set("@parameter", { inherit = "@parameter", italic = true })
  link("@text.diff.add", "GitSignsAdd")
  link("@text.diff.delete", "GitSignsDelete")

  -- plugin
  set("CmpCursorLine", { bg = bg("PmenuSel") })
  set("CmpDoc", { inherit = "PmenuSel", blend = 0 })
  link("FloatTitle", "Title")
  for i, p in ipairs({ "iris", "foam", "gold", "rose", "pine", "subtle" }) do
    set(("HeadLine%d"):format(i), { fg = c[p], bg = blend(c[p], c.base, 0.05) })
  end
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
    local color = blend(fg(border), c.base, 0.05)
    set(title, { inherit = border, bg = color })
    link(fmt("Notify%sIcon", v), title)
    link(fmt("Notify%sBody", v), title)
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
  end

  set("StatusLineDim", { inherit = "StatusLine", fg = c.muted })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.iris })
  set("StatusLineGitDiffAdd", { inherit = "StatusLine", fg = c.foam })
  set("StatusLineGitDiffChange", { inherit = "StatusLine", fg = c.rose })
  set("StatusLineGitDiffDelete", { inherit = "StatusLine", fg = c.love })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.love })
  set("StatusLinePath", { inherit = "StatusLine", fg = c.highlight_high })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.love })

  for k, v in pairs({
    Normal = c.rose,
    Insert = c.foam,
    Visual = c.iris,
    Replace = c.pine,
    Command = c.love,
  }) do
    local def = { inherit = "StatusLine", fg = v, bold = true }
    set(fmt("StatusLineM%s", k), def)
  end

  set("TabLineModified", { inherit = "TabLine", fg = c.love })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.love })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.rose })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  link("TelescopePreviewLine", "TelescopeSelection")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopePromptNormal", { bg = bg("StatusLine") })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  set("TodoLink", { fg = c.pine })
  set("TodoTest", { fg = c.rose })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = c.text,
  })
  set("WinSeparatorZen", { fg = c.base })
end)
