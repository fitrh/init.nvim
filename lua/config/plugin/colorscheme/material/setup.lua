local function get_variant()
  local variants = {
    lighter = "lighter",
    darker = "darker",
    ["deep ocean"] = "deep ocean",
    oceanic = "oceanic",
    palenight = "palenight",
  }

  return variants[os.getenv("NVIM_MATERIAL_VARIANT")] or "deep ocean"
end

vim.g.material_style = get_variant()
require("material").setup({
  contrast = {
    sidebar = true,
    floating_windows = true,
  },
  style = {
    comments = { italic = true },
    keywords = { italic = true },
  },
  plugins = {
    "gitsigns",
    "nvim-cmp",
    "nvim-web-devicons",
    "telescope",
    "trouble",
  },
  disable = {
    colored_cursor = true,
  },
  async_loading = false,
})

vim.cmd.colorscheme("material")

local c = require("material.colors")

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local fmt = string.format

  -- highlight-default
  set("ColorColumn", { bg = blend(c.editor.bg_alt, c.editor.bg, 0.3) })
  set("CursorColumn", { bg = blend(c.editor.highlight, c.editor.bg, 0.3) })
  link("CursorLine", "CursorColumn")
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("MatchParen", "LspReferenceText")
  link("MsgArea", "StatusLine")
  set("StatusLine", { fg = c.editor.fg_dark, bg = c.editor.bg_alt })
  link("TabLine", "StatusLine")
  link("TablineFill", "TabLine")
  set("TabLineSel", { inherit = "Normal", fg = c.editor.accent })

  -- lsp-highlight
  set("LspSignatureActiveParameter", { fg = c.editor.accent })

  -- treesitter-highlight-groups
  link("@text.diff.add", "diffAdded")
  link("@text.diff.delete", "diffRemoved")

  -- plugin
  link("CmpCursorLine", "CursorLine")
  set("CmpDoc", { inherit = "PmenuSbar", blend = 0 })
  set("CmpItemKindFile", { fg = c.editor.fg })
  link("FloatTitle", "Title")
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("NonText") })
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineTail", { fg = c.editor.line_numbers, bold = true })
  set("InclineWinNr", {
    fg = fg("CursorLineNr"),
    bg = blend(fg("CursorLineNr"), bg("StatusLine"), 0.1),
  })
  local p = { "purple", "cyan", "darkgreen", "yellow", "darkpurple", "gray" }
  for i, v in ipairs(p) do
    local group = ("HeadLine%d"):format(i)
    set(group, { fg = c.main[v], bg = blend(c.main[v], c.editor.bg, 0.05) })
  end
  set("LTSymbol", { fg = c.main.paleblue })
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
  set("ModesCopy", { bg = c.main.darkyellow })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = c.main.red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = c.main.darkgreen })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = c.main.purple })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })

  --- github.com/rcarriga/nvim-notify
  link("NotifyTRACETitle", "DiagnosticHint")
  set("NotifyDEBUGTitle", { fg = c.main.paleblue })
  link("NotifyINFOTitle", "DiagnosticInfo")
  link("NotifyWARNTitle", "DiagnosticWarn")
  link("NotifyERRORTitle", "DiagnosticError")
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local title = fmt("Notify%sTitle", v)
    local color = blend(fg(title), c.editor.bg, 0.05)
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
  end

  set("StatusLineDim", { inherit = "StatusLine", fg = c.editor.line_numbers })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.main.purple })
  set("StatusLineGitDiffAdd", { inherit = "StatusLine", fg = c.main.green })
  set("StatusLineGitDiffChange", { inherit = "StatusLine", fg = c.main.blue })
  set("StatusLineGitDiffDelete", { inherit = "StatusLine", fg = c.main.red })
  set("StatusLineModified", { inherit = "StatusLine", fg = c.main.red })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = c.main.darkred })
  for k, v in pairs({
    Normal = c.editor.accent,
    Insert = c.main.green,
    Visual = c.main.purple,
    Replace = c.main.red,
    Command = c.main.yellow,
  }) do
    local def = { inherit = "StatusLine", fg = v, bold = true }
    set(fmt("StatusLineM%s", k), def)
  end
  set("TabLineModified", { inherit = "TabLine", fg = c.main.red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.main.red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.editor.accent })
  local telescope_bg = bg("TelescopeNormal")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = telescope_bg, fg = telescope_bg })
  link("TelescopePromptBorder", "TelescopeBorder")
  link("TelescopePreviewBorder", "TelescopeBorder")
  link("TelescopeResultsBorder", "TelescopeBorder")
  set("TodoLink", { fg = c.main.paleblue })
  set("TodoTest", { fg = c.main.darkpurple })
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = c.editor.fg,
  })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
