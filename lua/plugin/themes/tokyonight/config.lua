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
local hlgroups = {
  CursorLineNr = ("gui=BOLD guifg=%s"):format(c.blue),
  ColorColumn = ("guibg=%s"):format(c.bg_statusline),
  TabLineSel = ("guifg=%s guibg=%s"):format(c.fg, c.bg),
  TabLine = ("guifg=%s guibg=%s"):format(c.fg_gutter, c.bg_statusline),
  TabLineFill = ("guifg=%s guibg=%s"):format(c.fg_gutter, c.bg_statusline),
  DiagnosticSignError = ("gui=BOLD guifg=%s"):format(c.error),
  DiagnosticSignWarn = ("gui=BOLD guifg=%s"):format(c.warning),
  DiagnosticSignInfo = ("gui=BOLD guifg=%s"):format(c.info),
  DiagnosticSignHint = ("gui=BOLD guifg=%s"):format(c.hint),
  GitSignsAddNr = ("gui=bold guifg=%s"):format(c.gitSigns.add),
  GitSignsChangeNr = ("gui=bold guifg=%s"):format(c.gitSigns.change),
  GitSignsDeleteNr = ("gui=bold guifg=%s"):format(c.gitSigns.delete),
  GitSignsDeleteLn = ("guifg=%s"):format(c.gitSigns.delete),
}

for group, hl in pairs(hlgroups) do
  vim.cmd(("highlight %s %s"):format(group, hl))
end
