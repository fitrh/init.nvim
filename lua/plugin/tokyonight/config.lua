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
  VertSplit = ("guifg=%s"):format(c.bg_statusline),
  LspDiagnosticsSignError = ("gui=BOLD guifg=%s"):format(c.error),
  LspDiagnosticsSignWarning = ("gui=BOLD guifg=%s"):format(c.warning),
  LspDiagnosticsSignInformation = ("gui=BOLD guifg=%s"):format(c.info),
  LspDiagnosticsSignHint = ("gui=BOLD guifg=%s"):format(c.hint),
}

for group, hl in pairs(hlgroups) do
  vim.cmd(("highlight %s %s"):format(group, hl))
end
