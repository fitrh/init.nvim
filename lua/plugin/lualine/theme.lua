local hi = require("sugar.highlight")

local theme = {}
local modes = { "Normal", "Insert", "Visual", "Replace", "Command" }

for _, mode in ipairs(modes) do
  theme[mode:lower()] = {
    a = {
      fg = hi.fg(("StatusLineM%s"):format(mode), { "StatusLine" }),
      bg = hi.bg("StatusLine"),
    },
    b = "StatusLine",
    c = "StatusLine",
  }
end

theme.inactive = {
  a = "StatusLineNC",
  b = "StatusLineNC",
  c = "StatusLineNC",
}

return theme
