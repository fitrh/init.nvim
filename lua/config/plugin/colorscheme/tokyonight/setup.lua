local config = {
  style = "night",
  darkFloat = false,
  darkSidebar = false,
}

vim.g.tokyonight_style = config.style
vim.g.tokyonight_dark_float = config.darkFloat
vim.g.tokyonight_dark_sidebar = config.darkSidebar

require("tokyonight").colorscheme()

local c = require("tokyonight.colors").setup(config)
local u = require("tokyonight.util")

require("sugar.highlight").colorscheme(function(h)
  local set, link, bg, blend = h.set, h.link, h.bg, h.blend

  -- highlight-default
  set("CursorLineNr", { fg = c.blue })
  set("ColorColumn", { bg = c.bg_statusline })
  link("TabLineSel", "Normal")
  link("TabLine", "StatusLineNC")
  link("TabLineFill", "TabLine")
  set("VertSplit", { fg = c.bg_statusline, cterm = { reverse = true } })

  -- treesitter
  set("TSConstBuiltin", { fg = c.red })

  -- plugin
  link("CmpCursorLine", "CursorLine")
  link("CmpDocumentationBorder", "LineNr")
  link("InclineNormal", "StatusLine")
  link("InclineNormalNC", "StatusLineNC")
  set("InclineWinNr", { fg = c.blue, bg = blend(c.blue, c.bg_statusline, 0.1) })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("ModesCopy", { bg = bg("IncSearch") })
  set("ModesDelete", { bg = c.red })
  set("ModesInsert", { bg = c.green })
  set("ModesVisual", { bg = c.purple })
  link("NotifyTRACEBorder", "DiagnosticHint")
  link("NotifyTRACETitle", "NotifyTRACEBorder")
  link("NotifyTRACEIcon", "NotifyTRACEBorder")
  set("NotifyDEBUGBorder", { fg = c.fg_dark })
  link("NotifyDEBUGTitle", "NotifyDEBUGBorder")
  link("NotifyDEBUGIcon", "NotifyDEBUGBorder")
  link("NotifyINFOBorder", "DiagnosticInfo")
  link("NotifyINFOTitle", "NotifyINFOBorder")
  link("NotifyINFOIcon", "NotifyINFOBorder")
  link("NotifyWARNBorder", "DiagnosticWarn")
  link("NotifyWARNTitle", "NotifyWARNBorder")
  link("NotifyWARNIcon", "NotifyWARNBorder")
  link("NotifyERRORBorder", "DiagnosticError")
  link("NotifyERRORTitle", "NotifyERRORBorder")
  link("NotifyERRORIcon", "NotifyERRORBorder")
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = c.purple })
  set("StatusLineModified", {
    inherit = "StatusLine",
    fg = u.brighten(c.red, 0.2),
  })
  link("StatusLinePath", "StatusLineNC")
  set("StatusLineRO", { inherit = "StatusLine", fg = c.red1 })
  set("StatusLineMNormal", { fg = c.blue })
  set("StatusLineMInsert", { fg = c.green })
  set("StatusLineMVisual", { fg = c.purple })
  set("StatusLineMReplace", { fg = c.red })
  set("StatusLineMCommand", { fg = c.yellow })
  set("TabLineModified", { inherit = "TabLine", fg = c.red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = c.red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = c.blue })
  set("TreesitterContext", { bg = c.bg_statusline })
  set("WinSeparatorZen", { fg = c.bg })
end)
