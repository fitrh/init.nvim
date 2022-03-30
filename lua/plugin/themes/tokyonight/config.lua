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
local hi = require("sugar.highlight")

local hlgroups = {
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
  GitSignsAddNr = { fg = c.gitSigns.add },
  GitSignsChangeNr = { fg = c.gitSigns.change },
  GitSignsDeleteNr = { fg = c.gitSigns.delete },
  GitSignsDeleteLn = { fg = c.gitSigns.delete },
}

for group, hl in pairs(hlgroups) do
  hi.set(group, hl)
end
