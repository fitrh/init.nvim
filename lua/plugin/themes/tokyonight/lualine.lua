local palette = require("plugin.themes.tokyonight.palette")
local ok, theme = pcall(require, "lualine.themes.tokyonight")

if not ok then
  return "auto"
end

theme.normal.a = { fg = palette.blue, bg = palette.bg_statusline }
theme.insert.a = { fg = palette.green.primary, bg = palette.bg_statusline }
theme.visual.a = { fg = palette.purple, bg = palette.bg_statusline }
theme.replace.a = { fg = palette.red, bg = palette.bg_statusline }
theme.command.a = { fg = palette.yellow, bg = palette.bg_statusline }

return theme
