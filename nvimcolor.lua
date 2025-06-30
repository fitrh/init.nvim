-- #07080D DarkGrey1
-- #14161B DarkGrey2
-- #2C2E33 DarkGrey3
-- #4F5258 DarkGrey4
-- #EEF1F8 LightGrey1
-- #E0E2EA LightGrey2
-- #C4C6CD LightGrey3
-- #9B9EA4 LightGrey4
-- #004C73 DarkBlue
-- #A6DBFF LightBlue
-- #007373 DarkCyan
-- #8CF8F7 LightCyan
-- #005523 DarkGreen
-- #B3F6C0 LightGreen
-- #470045 DarkMagenta
-- #FFCAFF LightMagenta
-- #590008 DarkRed
-- #FFC0B9 LightRed
-- #6B5300 DarkYellow
-- #FCE094 LightYellow
local colors = {}
for i = 1, 4 do
  colors[#colors + 1] = "NvimDarkGrey" .. i
  colors[#colors + 1] = "NvimLightGrey" .. i
end
for _, color in ipairs({ "Blue", "Cyan", "Green", "Magenta", "Red", "Yellow" }) do
  colors[#colors + 1] = "NvimDark" .. color
  colors[#colors + 1] = "NvimLight" .. color
end

for _, c in ipairs(colors) do
  print(string.format("#%06X %s", vim.api.nvim_get_color_by_name(c), c))
end
