local config = {
  style = "night",
  lualineBold = false,
  darkFloat = false,
  darkSidebar = false,
  sidebars = { "Outline" },
}

vim.g.tokyonight_style = config.style
vim.g.tokyonight_lualine_bold = config.lualineBold
vim.g.tokyonight_dark_float = config.darkFloat
vim.g.tokyonight_dark_sidebar = config.darkSidebar
vim.g.tokyonight_sidebars = config.sidebars

require("tokyonight").colorscheme()

local c = require("tokyonight.colors").setup(config)
local u = require("tokyonight.util")
local hi = require("sugar.highlight")

---@type table<string, HighlightDef>
local highlights = {
  -- highlight-default
  CursorLineNr = { fg = c.blue },
  ColorColumn = { bg = c.bg_statusline },
  TabLineSel = { fg = c.fg, bg = c.bg },
  TabLine = { fg = c.fg_gutter, bg = c.bg_statusline },
  TabLineFill = { fg = c.fg_gutter, bg = c.bg_statusline },
  VertSplit = { fg = hi.bg("StatusLine"), cterm = { reverse = true } },

  -- treesitter
  TSConstBuiltin = { fg = c.red },

  -- plugin
  InclineNormal = { link = "StatusLine" },
  InclineNormalNC = { link = "StatusLineNC" },
  ModesCopy = { bg = hi.bg("IncSearch") },
  ModesDelete = { bg = c.red },
  ModesInsert = { bg = c.fg_dark },
  ModesVisual = { bg = c.purple },
  NotifyTRACEBorder = { link = "DiagnosticHint" },
  NotifyTRACETitle = { link = "NotifyTRACEBorder" },
  NotifyTRACEIcon = { link = "NotifyTRACEBorder" },
  NotifyDEBUGBorder = { fg = c.fg_dark },
  NotifyDEBUGTitle = { link = "NotifyDEBUGBorder" },
  NotifyDEBUGIcon = { link = "NotifyDEBUGBorder" },
  NotifyINFOBorder = { link = "DiagnosticInfo" },
  NotifyINFOTitle = { link = "NotifyINFOBorder" },
  NotifyINFOIcon = { link = "NotifyINFOBorder" },
  NotifyWARNBorder = { link = "DiagnosticWarn" },
  NotifyWARNTitle = { link = "NotifyWARNBorder" },
  NotifyWARNIcon = { link = "NotifyWARNBorder" },
  NotifyERRORBorder = { link = "DiagnosticError" },
  NotifyERRORTitle = { link = "NotifyERRORBorder" },
  NotifyERRORIcon = { link = "NotifyERRORBorder" },
  StatusLineGitBranch = { inherit = "StatusLine", fg = c.purple },
  StatusLineModified = { inherit = "StatusLine", fg = u.brighten(c.red, 0.2) },
  StatusLineRO = { inherit = "StatusLine", fg = c.red1 },
  StatusLineMNormal = { fg = c.blue },
  StatusLineMInsert = { fg = c.green },
  StatusLineMVisual = { fg = c.purple },
  StatusLineMReplace = { fg = c.red },
  StatusLineMCommand = { fg = c.yellow },
  TreesitterContext = { link = "LspReferenceText" },
}

for group, def in pairs(highlights) do
  hi.set(group, def)
end
