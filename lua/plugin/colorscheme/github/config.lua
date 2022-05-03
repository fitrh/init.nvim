local config = {}

config.theme_style = "dark_default"

require("github-theme").setup(config)

local p = require("github-theme.palette").get_palette(config.theme_style)
local hi = require("sugar.highlight")

hi.colorscheme({
  -- highlight-default
  { "ColorColumn", bg = p.bg2 },
  { "CursorLineNr", fg = p.bright_blue },
  { "StatusLine", bg = p.bg2, fg = p.fg },
  { "TabLineSel", fg = p.fg, bg = p.bg, bold = true },
  { "TabLine", inherit = "StatusLine", fg = p.fg_dark },
  { "TabLineFill", link = "TabLine" },
  { "VertSplit", fg = p.bg2 },

  -- plugin
  { "FidgetTask", inherit = "Comment", italic = false },
  { "InclineNormal", link = "StatusLine" },
  { "InclineNormalNC", inherit = "StatusLine", fg = hi.fg("Comment") },
  { "ModesCopy", bg = p.warning },
  { "ModesDelete", bg = p.red },
  { "ModesInsert", bg = p.fg_gutter },
  { "ModesVisual", bg = p.bright_magenta },
  { "StatusLineGitBranch", inherit = "StatusLine", fg = p.magenta },
  { "StatusLineModified", inherit = "StatusLine", fg = p.bright_red },
  { "StatusLineRO", inherit = "StatusLine", fg = p.red },
  { "StatusLineMNormal", fg = p.bright_blue },
  { "StatusLineMInsert", fg = p.green },
  { "StatusLineMVisual", fg = p.bright_magenta },
  { "StatusLineMReplace", fg = p.red },
  { "StatusLineMCommand", fg = p.yellow },
  { "TreesitterContext", link = "LspReferenceText" },
})
