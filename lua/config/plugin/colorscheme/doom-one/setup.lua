vim.g.doom_one_italic_comments = true
vim.g.doom_one_pumblend_enable = false
vim.g.doom_one_pumblend_transparency = vim.api.nvim_get_option("pumblend")
vim.g.doom_one_plugin_neorg = false
vim.g.doom_one_plugin_barbar = false
vim.g.doom_one_plugin_telescope = true
vim.g.doom_one_plugin_neogit = false
vim.g.doom_one_plugin_nvim_tree = false
vim.g.doom_one_plugin_dashboard = false
vim.g.doom_one_plugin_startify = false
vim.g.doom_one_plugin_whichkey = false
vim.g.doom_one_plugin_indent_blankline = false
vim.g.doom_one_plugin_vim_illuminate = false
vim.g.doom_one_plugin_lspsaga = false

local function get_mode()
  local modes = { dark = "dark", light = "light" }
  return modes[os.getenv("NVIM_DOOM_ONE_MODE")] or "dark"
end

vim.api.nvim_set_option_value("background", get_mode(), {})
vim.cmd.colorscheme("doom-one")

require("sugar.highlight").colorscheme(function(h)
  local set, link = h.set, h.link
  local fg, bg = h.fg, h.bg
  local blend = h.blend
  local fmt, concat = string.format, table.concat
  local background = vim.api.nvim_get_option_value("background", {})

  local function lightdark(use_this, else_this)
    return background == "light" and use_this or else_this
  end

  local p = require("doom-one.colors").get_palette(background)

  -- highlight-default
  set("ColorColumn", {
    bg = blend(bg("ColorColumn"), p.bg, lightdark(0.8, 0.4)),
  })
  set("CursorColumn", {
    bg = blend(bg("CursorColumn"), p.bg, lightdark(1, 0.5)),
  })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { fg = p.base7 })
  set("Folded", { inherit = "Folded", bg = "NONE" })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  set("LineNr", { fg = p[lightdark("base4", "base5")] })
  link("MatchParen", "LspReferenceText")
  link("MsgArea", "StatusLine")
  set("StatusLine", { inherit = "StatusLine", fg = p.base7 })
  set("StatusLineNC", { inherit = "StatusLineNC", fg = p.base5 })
  link("TabLineFill", "TabLine")

  -- treesitter-highlight-groups
  set("@diff.plus", { inherit = "DiffAddedGutter", bold = false })
  set("@diff.minus", { inherit = "DiffRemovedGutter", bold = false })

  -- diagnostic-highlights
  link("DiagnosticError", "DiagnosticDefaultError")
  link("DiagnosticWarn", "DiagnosticDefaultWarn")
  link("DiagnosticInfo", "DiagnosticDefaultInfo")
  link("DiagnosticHint", "DiagnosticDefaultHint")
  for _, v in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    local group = ("DiagnosticUnderline%s"):format(v)
    set(group, { inherit = group, underline = false, undercurl = true })
  end

  -- plugin
  link("CmpCursorLine", "Visual")
  set("CmpDoc", { inherit = "PmenuThumb", blend = 0 })
  set("CmpItemKindInterface", { fg = p.dark_blue })
  set("CmpItemKindColor", { fg = p.yellow })
  set("CmpItemKindTypeParameter", { fg = p.yellow })
  set("CmpItemKindText", { fg = p.yellow })
  set("CmpItemKindEnum", { fg = p.orange })
  set("CmpItemKindKeyword", { fg = p.blue })
  set("CmpItemKindConstant", { fg = p.violet })
  set("CmpItemKindConstructor", { fg = p.red })
  set("CmpItemKindReference", { fg = p.dark_cyan })
  set("CmpItemKindFunction", { fg = p.magenta })
  set("CmpItemKindStruct", { fg = p.blue })
  set("CmpItemKindClass", { fg = p.dark_blue })
  set("CmpItemKindModule", { fg = p.teal })
  set("CmpItemKindOperator", { fg = p.blue })
  set("CmpItemKindField", { fg = p.teal })
  set("CmpItemKindProperty", { fg = p.magenta })
  set("CmpItemKindEvent", { fg = p.orange })
  set("CmpItemKindUnit", { fg = p.orange })
  set("CmpItemKindSnippet", { fg = p[lightdark("base5", "fg_alt")] })
  set("CmpItemKindFolder", { fg = p.blue })
  set("CmpItemKindVariable", { fg = p.violet })
  set("CmpItemKindFile", { fg = p.fg })
  set("CmpItemKindMethod", { fg = p.cyan })
  set("CmpItemKindValue", { fg = p.fg })
  set("CmpItemKindEnumMember", { fg = p.red })
  link("FloatTitle", "Title")
  link("GitSignsAdd", "DiffAdd")
  link("GitSignsChange", "DiffChange")
  link("GitSignsDelete", "DiffDelete")
  link("InclineNormal", "StatusLine")
  link("InclineNormalNC", "StatusLineNC")
  set("InclineSep", { fg = fg("StatusLineNC"), bold = true })
  set("InclineTail", { fg = p.base6, bold = true })
  set("InclineWinNr", {
    fg = p.blue,
    bg = blend(p.blue, bg("StatusLine"), 0.1),
  })
  set("LTSymbol", { fg = p.fg })
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
  set("ModesCopy", { bg = p.yellow })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = p.red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = p.green })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = p.magenta })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })

  --- github.com/rcarriga/nvim-notify
  link("NotifyTRACETitle", "DiagnosticHint")
  set("NotifyDEBUGTitle", { fg = p.fg_alt })
  link("NotifyINFOTitle", "DiagnosticInfo")
  link("NotifyWARNTitle", "DiagnosticWarn")
  link("NotifyERRORTitle", "DiagnosticError")
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local title = fmt("Notify%sTitle", v)
    local color = blend(fg(title), p.bg, lightdark(0.1, 0.05))
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
    link(concat({ "Notify", v, "Icon" }), title)
  end

  set("StatusLineDim", { inherit = "StatusLine", fg = p.base5 })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = p.violet })
  set("StatusLineGitDiffAdd", { inherit = "StatusLine", fg = p.green })
  set("StatusLineGitDiffChange", { inherit = "StatusLine", fg = p.orange })
  set("StatusLineGitDiffDelete", { inherit = "StatusLine", fg = p.red })
  set("StatusLineModified", { inherit = "StatusLine", fg = p.red })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("StatusLineNC") })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = p.red })
  set("TabLineModified", { inherit = "TabLine", fg = p.red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = p.red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = p.blue })
  set("TelescopeNormal", { bg = p.bg_alt })
  set("TelescopePreviewLine", { bg = p.bg })
  set("TelescopeSelection", { bg = p.bg })
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = p.bg_alt, fg = p.bg_alt })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = p.fg,
  })
  set("WinSeparatorZen", { fg = p.bg })
end)
