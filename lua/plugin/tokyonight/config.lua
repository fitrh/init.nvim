local g = vim.g

g.tokyonight_style = "night"
g.tokyonight_lualine_bold = true
g.tokyonight_dark_float = false
g.tokyonight_dark_sidebar = false
g.tokyonight_sidebars = { "Outline" }

vim.cmd[[colorscheme tokyonight]]

local c = require("tokyonight.colors").setup()
local hlgroups = {
  ["CursorLineNr"] = ("gui=BOLD guifg=%s"):format(c.blue),
  ["ColorColumn"] = ("guibg=%s"):format(c.bg_statusline),
  ["TabLineSel"] = ("guifg=%s guibg=%s"):format(c.fg, c.bg),
  ["TabLine"] = ("guifg=%s guibg=%s"):format(c.fg_gutter, c.bg_statusline),
  ["TabLineFill"] = ("guifg=%s guibg=%s"):format(c.fg_gutter, c.bg_statusline),
  ["VertSplit"] = ("guifg=%s"):format(c.bg_statusline),
}

for group,hl in pairs(hlgroups) do
  vim.cmd(("highlight %s %s"):format(group, hl))
end
