local palette = {
  dark = {
    c00 = "#000000", -- 16 black
    c08 = "#767676", -- 243 darkgrey
    c01 = "#AF5F5F", -- 131 darkred
    c09 = "#FF5F5F", -- 203 red
    c02 = "#5FAF5F", -- 71 darkgreen
    c10 = "#5FD75F", -- 77 green
    c03 = "#AF875F", -- 137 darkyellow
    c11 = "#FFD787", -- 222 yellow
    c04 = "#5F87AF", -- 67 darkblue
    c12 = "#5FAFFF", -- 75 blue
    c05 = "#D787D7", -- 176 darkmagenta
    c13 = "#FF87FF", -- 213 magenta
    c06 = "#5FAFAF", -- 73 darkcyan
    c14 = "#5FD7D7", -- 116 cyan
    c07 = "#C6C6C6", -- 251 grey
    c15 = "#FFFFFF", -- 231 white
    DimWhite = "#E4E4E4", -- 254 grey
    Line = "#262626", -- 235 darkgrey
    B = "#303030", -- 236 darkgrey
    NonT = "#585858", -- 240 grey
    lC = "#FF5FFF", -- 207 magenta
    V = "#005F87", -- 24 darkblue
    MP = "#C5E7C5", -- 30 darkcyan
    PMenuSel = "#4e4e4e", -- 239 darkcyan
    Dim = "#878787", -- 102 grey
    diffAdd = "#875f87", -- 96 darkmagenta
    diffDelete = "#D78787", -- 174 darkred
    diffChange = "#5f5f5f", -- 59 darkgreen
    diffText = "#5f8787", -- 66 cyan
    fgDiffText = "#afffff", -- 159 black
  },
  light = {
    c00 = "#000000", -- 16 black
    c08 = "#767676", -- 243 darkgrey
    c01 = "#AF0000", -- 124 darkred
    c09 = "#D70000", -- 160 red
    c02 = "#008700", -- 28 darkgreen
    c10 = "#87D787", -- 114 green
    c03 = "#AF5F00", -- 130 darkyellow
    c11 = "#FFD787", -- 222 yellow
    c04 = "#005FD7", -- 26 darkblue
    c12 = "#0087D7", -- 32 blue
    c05 = "#AF00AF", -- 127 darkmagenta
    c13 = "#FF00FF", -- 133 magenta
    c06 = "#005F5F", -- 23 darkcyan
    c14 = "#008787", -- 30 cyan
    c07 = "#808080", -- 244 grey
    c15 = "#FFFFFF", -- 231 white
    Line = "#EEEEEE", -- 255 grey
    B = "#E4E4E4", -- 254 grey
    NonT = "#9E9E9E", -- 247 darkgrey
    Tab = "#BCBCBC", -- 250 lightgrey
    C = "#000000", -- 16 black
    lC = "#FF00FF", -- 201 magenta
    V = "#5F87AF", -- 67 darkblue
    MP = "#C5E7C5", -- 30 darkcyan
    PMenuSel = "#C6C6C6", -- 251 darkcyan
    Dim = "#626262", -- 241 darkgrey
    diffAdd = "#D7AFD7", -- 182 darkmagenta
    diffDelete = "#870000", -- 88 darkred
    diffChange = "#D0D0D0", -- 252 lightgray
    diffText = "#5FD7D7", -- 80 cyan
    fgDiffText = "#000000", -- 16 black
  },
}
local c = palette[vim.api.nvim_get_option_value("background", {})]
if not c then
  return
end

local g = {}
g.NormalFloat = { fg = c.c07, bg = c.B }
g.StatusLine = { fg = c.c07, bg = c.B }
g.StatusLineNc = { fg = c.c08, bg = g.StatusLine.bg }
-- g.WinSeparator = { fg = c.B } -- TODO: check if 'laststatus' is 3

-- plugin
--- cmp
g.CmpCursorLine = { link = "PmenuSel" }
--- statusline
g.StatusLineDim = { fg = c.Dim, bg = g.StatusLine.bg }
g.StatusLineFilename = {
  fg = g.StatusLine.fg,
  bg = g.StatusLine.bg,
  bold = true,
}
g.StatusLineModified = { fg = c.c09, bg = g.StatusLine.bg }
g.StatusLinePath = { fg = c.c08, bg = g.StatusLine.bg }
g.StatusLineRO = { fg = c.c01, bg = g.StatusLine.bg }
--- telescope
g.TelescopeNormal = { link = "NormalFloat" }
g.TelescopeBorder = { fg = c.B, bg = c.B }
g.TelescopeSelection = { link = "PmenuSel" }
g.TelescopeTitle = { link = "Visual" }

local set = vim.api.nvim_set_hl
for name, val in pairs(g) do
  set(0, name, val)
end
