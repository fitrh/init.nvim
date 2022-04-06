local g = vim.g

local config = {
  style = "night",
  lualineBold = false,
  darkFloat = false,
  darkSidebar = false,
  sidebars = { "Outline" },
}

g.tokyonight_style = config.style
g.tokyonight_lualine_bold = config.lualineBold
g.tokyonight_dark_float = config.darkFloat
g.tokyonight_dark_sidebar = config.darkSidebar
g.tokyonight_sidebars = config.sidebars

vim.cmd("colorscheme tokyonight")

local c = require("tokyonight.colors").setup(config)
local u = require("tokyonight.util")
local hi = require("sugar.highlight")

---@type table<string, HighlightDef>
local highlights = {
  -- Builtin
  CursorLineNr = { fg = c.blue },
  ColorColumn = { bg = c.bg_statusline },
  TabLineSel = { fg = c.fg, bg = c.bg },
  TabLine = { fg = c.fg_gutter, bg = c.bg_statusline },
  TabLineFill = { fg = c.fg_gutter, bg = c.bg_statusline },
  DiagnosticSignError = { fg = c.error },
  DiagnosticSignWarn = { fg = c.warning },
  DiagnosticSignInfo = { fg = c.info },
  DiagnosticSignHint = { fg = c.hint },
  VertSplit = { fg = hi.bg("StatusLine"), cterm = { reverse = true } },

  -- Plugin
  GitSignsAddNr = { fg = c.gitSigns.add },
  GitSignsChangeNr = { fg = c.gitSigns.change },
  GitSignsDeleteNr = { fg = c.gitSigns.delete },
  GitSignsDeleteLn = { fg = c.gitSigns.delete },
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
  StatusLineMNormal = { fg = c.blue },
  StatusLineMInsert = { fg = c.green },
  StatusLineMVisual = { fg = c.purple },
  StatusLineMReplace = { fg = c.red },
  StatusLineMCommand = { fg = c.yellow },
  StatusLineRO = { inherit = "StatusLine", fg = c.red1 },
}

for group, def in pairs(highlights) do
  hi.set(group, def)
end
