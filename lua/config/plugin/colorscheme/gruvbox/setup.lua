local function get_mode()
  local modes = { dark = "dark", light = "light" }
  return modes[os.getenv("NVIM_GRUVBOX_MODE")] or "dark"
end

local function get_variant()
  local variants = { soft = "soft", hard = "hard" }
  return variants[os.getenv("NVIM_GRUVBOX_VARIANT")] or ""
end

local mode = get_mode()
local variant = get_variant()
vim.api.nvim_set_option("background", mode)
local gruvbox = require("gruvbox")
gruvbox.setup({ contrast = variant })
gruvbox.load()

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local fmt = string.format
  local c = require("gruvbox.palette").colors
  local p = require("gruvbox.palette").get_base_colors(mode, variant)
  local base = { fg = p.fg1, bg = p.bg0 }

  -- highlight-default
  set("ColorColumn", { bg = blend(bg("ColorColumn"), base.bg, 0.1) })
  set("CursorColumn", { bg = blend(bg("CursorLine"), base.bg, 0.3) })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { fg = p.yellow })
  set("DiagnosticSignInfo", { inherit = "DiagnosticSignInfo", bg = "NONE" })
  set("DiagnosticSignWarn", { inherit = "DiagnosticSignWarn", bg = "NONE" })
  set("DiagnosticSignHint", { inherit = "DiagnosticSignHint", bg = "NONE" })
  set("DiagnosticSignError", { inherit = "DiagnosticSignError", bg = "NONE" })
  set("DiffAdd", { inherit = "DiffAdd", reverse = false })
  set("DiffChange", { inherit = "DiffChange", reverse = false })
  set("DiffDelete", { inherit = "DiffDelete", reverse = false })
  set("DiffText", { inherit = "DiffText", reverse = false })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  set("FoldColumn", { inherit = "FoldColumn", bg = "NONE" })
  set("Folded", { inherit = "Folded", bg = "NONE" })
  link("MsgArea", "StatusLine")
  link("SignColumn", "LineNr")
  set("StatusLine", { bg = p.bg1, fg = p.fg3 })
  set("TabLineSel", { inherit = "TabLineSel", bg = base.bg })
  set("VertSplit", { fg = p.bg1 })

  -- :h treesitter-highlight-groups
  set("@text.todo.checked", { fg = fg("Done") })
  set("@text.todo.unchecked", { fg = fg("Todo"), bold = true })

  -- health
  link("healthError", "DiagnosticError")
  set("healthSuccess", { fg = p.green })
  link("healthWarning", "DiagnosticWarn")

  -- plugin
  link("CmpCursorLine", "Visual")
  set("CmpDoc", { inherit = "PmenuThumb", blend = 0 })
  link("FloatTitle", "Title")
  set("GitSignsAdd", { inherit = "GitSignsAdd", bg = "NONE" })
  set("GitSignsChange", { inherit = "GitSignsChange", bg = "NONE" })
  set("GitSignsDelete", { inherit = "GitSignsDelete", bg = "NONE" })
  for i, v in ipairs({
    p.purple,
    p.aqua,
    p.blue,
    p["neutral_yellow"],
    p["neutral_green"],
    p["neutral_purple"],
  }) do
    set(("HeadLine%s"):format(i), { fg = v, bg = blend(v, base.bg, 0.05) })
  end
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("Comment") })
  set("InclineSep", { fg = fg("Comment"), bold = true })
  set("InclineTail", { fg = p.fg4, bold = true })
  set("InclineWinNr", {
    fg = p.yellow,
    bg = blend(p.yellow, bg("StatusLine"), 0.1),
  })
  set("LspSignatureActiveParameter", { fg = p.yellow })
  set("LTSymbol", { fg = p.fg2 })
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
  set("ModesCopy", { bg = fg("IncSearch") })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = p.red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = p.blue })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = p.purple })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })

  --- github.com/rcarriga/nvim-notify
  link("NotifyTRACETitle", "DiagnosticHint")
  set("NotifyDEBUGTitle", { fg = c.gray })
  link("NotifyINFOTitle", "DiagnosticInfo")
  link("NotifyWARNTitle", "DiagnosticWarn")
  link("NotifyERRORTitle", "DiagnosticError")
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local title = fmt("Notify%sTitle", v)
    local color = blend(fg(title), base.bg, 0.05)
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
  end

  set("StatusLineDim", { inherit = "StatusLine", fg = p.fg4 })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = p.purple })
  for _, kind in ipairs({ "Add", "Change", "Delete" }) do
    local group = ("StatusLineGitDiff%s"):format(kind)
    set(group, { inherit = "StatusLine", fg = fg(("GitSigns%s"):format(kind)) })
  end
  set("StatusLineModified", { inherit = "StatusLine", fg = c.bright_red })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.faded_red })
  for k, v in pairs({
    Normal = p.yellow,
    Insert = p.blue,
    Visual = p.orange,
    Replace = p.aqua,
    Command = p.red,
  }) do
    local def = { inherit = "StatusLine", fg = v, bold = true }
    set(fmt("StatusLineM%s", k), def)
  end
  set("TabLineModified", { inherit = "TabLine", fg = c.bright_red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.bright_red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = p.blue })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  link("TelescopePreviewLine", "CursorLine")
  set("TelescopeTitle", { inherit = "Visual", fg = base.fg, bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  link("TelescopePromptBorder", "TelescopeBorder")
  link("TelescopePromptCounter", "StatusLine")
  link("TelescopePreviewBorder", "TelescopeBorder")
  link("TelescopeResultsBorder", "TelescopeBorder")
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = base.fg,
  })
  set("WinSeparatorZen", { fg = base.bg })
end)
