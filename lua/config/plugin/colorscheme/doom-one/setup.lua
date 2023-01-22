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

vim.api.nvim_set_option("background", get_mode())
vim.cmd.colorscheme("doom-one")

require("sugar.highlight").colorscheme(function(h)
  local set, link = h.set, h.link
  local fg, bg = h.fg, h.bg
  local blend = h.blend
  local fmt = string.format
  local p = require("doom-one.colors").get_palette(
    vim.api.nvim_get_option("background")
  )

  -- highlight-default
  set("ColorColumn", { bg = blend(bg("ColorColumn"), p.bg, 0.4) })
  set("CursorColumn", { bg = blend(bg("CursorColumn"), p.bg, 0.5) })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { inherit = "CursorLineNr", bg = p.bg })
  set("Folded", { inherit = "Folded", bg = "NONE" })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("MatchParen", "LspReferenceText")
  set("StatusLine", { inherit = "StatusLine", fg = p.base7 })
  set("StatusLineNC", { inherit = "StatusLineNC", fg = p.base5 })
  link("TabLineFill", "TabLine")
  set("VertSplit", { fg = bg("StatusLine") })

  -- treesitter-highlight-groups
  set("@text.diff.add", { inherit = "DiffAddedGutter", bold = false })
  set("@text.diff.delete", { inherit = "DiffRemovedGutter", bold = false })

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
  link("FloatTitle", "Title")
  link("GitSignsAdd", "DiffAdd")
  link("GitSignsChange", "DiffChange")
  link("GitSignsDelete", "DiffDelete")
  local c = { "magenta", "cyan", "yellow", "green", "violet", "dark_cyan" }
  for i, v in ipairs(c) do
    set(("HeadLine%d"):format(i), { fg = p[v], bg = blend(p[v], p.bg, 0.05) })
  end
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
    local color = blend(fg(title), p.bg, 0.05)
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
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
  for k, v in pairs({
    Normal = p.blue,
    Insert = p.green,
    Visual = p.magenta,
    Replace = p.red,
    Command = p.yellow,
  }) do
    local def = { inherit = "StatusLine", fg = v, bold = true }
    set(fmt("StatusLineM%s", k), def)
  end
  set("TabLineModified", { inherit = "TabLine", fg = p.red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = p.red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = p.blue })
  set("TelescopeNormal", { bg = p.bg_alt })
  set("TelescopePreviewLine", { bg = p.bg })
  set("TelescopeSelection", { bg = p.bg })
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = p.bg_alt, fg = p.bg_alt })
  set("TodoLink", { fg = p.dark_blue })
  set("TodoTest", { fg = p.violet })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = p.fg,
  })
  set("WinSeparatorZen", { fg = p.bg })
end)
