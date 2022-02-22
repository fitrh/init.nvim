local palette = require("plugin.themes.tokyonight.palette")
local ok, theme = pcall(require, "lualine.themes.tokyonight")

if not ok then
  return "auto"
end

theme.normal.a = { fg = palette.blue.primary, bg = palette.bg.dark }
theme.insert.a = { fg = palette.green.primary, bg = palette.bg.dark }
theme.visual.a = { fg = palette.magenta.secondary, bg = palette.bg.dark }
theme.replace.a = { fg = palette.red.primary, bg = palette.bg.dark }
theme.command.a = { fg = palette.yellow.primary, bg = palette.bg.dark }

return theme
