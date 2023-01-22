local theme = {}

for _, mode in ipairs({ "Normal", "Insert", "Visual", "Replace", "Command" }) do
  theme[mode:lower()] = {
    a = string.format("StatusLineM%s", mode),
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
