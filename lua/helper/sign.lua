local Sign = {}

Sign.line = {
  THIN = { left = "▏", center = "│", right = "▕" },
  LIGHT = "┃",
  HALF = { left = "▌", right = "▐" },
  HEAVY = "▊",
  FULL = "█",
  SHADE = { light = "░", medium = "▒", dark = "▓" },
  DOUBLE = "║",
}

Sign.diagnostic = {
  ERROR = "",
  WARN = "",
  INFO = "",
  HINT = "",
}

return Sign
