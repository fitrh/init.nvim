local function get_variant()
  local variants = {
    dark = "dark",
    dimmed = "dark_dimmed",
    dark_high_contrast = "dark_high_contrast",
    dark_colorblind = "dark_colorblind",
    dark_tritanopia = "dark_tritanopia",
    light = "light",
    light_high_contrast = "light_high_contrast",
    light_colorblind = "light_colorblind",
    light_tritanopia = "light_tritanopia",
  }

  return variants[os.getenv("NVIM_GITHUB_VARIANT")] or "dark_high_contrast"
end

local options = {}
options.darken = { floats = true }

require("github-theme").setup({ options = options })
local variant = get_variant()
local theme = "github_" .. variant
vim.api.nvim_cmd({ cmd = "colorscheme", args = { theme } }, {})

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local fmt = string.format

  local p = require("github-theme.palette").load(theme)
  local scale = p.scale
  local spec = p.generate_spec(p)
  local base = p.canvas.default

  -- highlight-default
  set("ColorColumn", { bg = blend(spec.bg2, base, 0.4) })
  set("CursorColumn", { bg = blend(p.blue.bright, base, 0.03) })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { fg = p.blue.bright })
  set("DiffAdd", { inherit = "DiffAdd", bg = "NONE" })
  set("DiffChange", { inherit = "DiffChange", bg = "NONE" })
  set("DiffDelete", { inherit = "DiffDelete", bg = "NONE" })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  link("Folded", "LineNr")
  link("MsgArea", "StatusLine")
  set("NonText", { fg = spec.fg3 })
  set("StatusLine", { fg = p.fg.muted, bg = spec.bg0 })
  link("TabLineSel", "Normal")
  set("TabLine", { inherit = "StatusLine", fg = spec.fg3 })
  link("TabLineFill", "TabLine")
  set("VertSplit", { fg = spec.fg3 })

  -- :h diagnostic-highlights
  set("DiagnosticUnderlineHint", {
    sp = fg("DiagnosticHint"),
    undercurl = true,
  })

  -- treesitter-highlight-groups
  set("@text.diff.add", { inherit = "diffAdded", bg = "NONE" })
  set("@text.diff.delete", { inherit = "diffRemoved", bg = "NONE" })

  -- plugin
  link("CmpCursorLine", "PmenuSel")
  set("CmpDoc", { inherit = "PmenuThumb", blend = 0 })
  set("FidgetTask", { inherit = "Comment", italic = false })
  link("FloatTitle", "Title")
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("Comment") })
  set("InclineSep", { fg = fg("LineNr"), bold = true })
  set("InclineTail", { fg = fg("Comment"), bold = true })
  set("InclineWinNr", {
    fg = p.blue.bright,
    bg = blend(p.blue.bright, spec.bg2, 0.1),
  })
  link("LTSymbolDetail", "Comment")
  link("LTSymbolJump", "LspReferenceText")
  set("ModesCopy", { bg = spec.diag.warn })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = p.red.base })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = p.green.base })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = p.magenta.bright })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })

  --- github.com/rcarriga/nvim-notify
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local title = fmt("Notify%sTitle", v)
    local color = blend(fg(title), base, 0.05)
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
  end

  set("StatusLineDim", { inherit = "StatusLine", fg = scale.gray[5] })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = p.magenta })
  for _, kind in ipairs({ "Add", "Change", "Delete" }) do
    local group = ("StatusLineGitDiff%s"):format(kind)
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = p.magenta.base })
  local gitspec = spec.git
  for k, v in pairs({ add = "Add", changed = "Change", removed = "Delete" }) do
    local group = concat({ "StatusLineGitDiff", v })
    set(group, { inherit = "StatusLine", fg = gitspec[k] })
  end
  set("StatusLineModified", { inherit = "StatusLine", fg = p.red.bright })
  set("StatusLinePath", {
    inherit = "StatusLine",
    fg = scale.gray[variant == "dark" and 5 or 6],
  })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = p.red.base })
  set("TabLineModified", { inherit = "TabLine", fg = p.red.base })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = p.red.base })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = p.blue.bright })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  link("TelescopePreviewLine", "CursorLine")
  link("TelescopeSelection", "CursorLine")
  set("TelescopeTitle", { inherit = "Visual", fg = fg("Normal"), bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  set("TreesitterContext", { inherit = "TreesitterContext", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = p.fg.default,
  })
  set("WinSeparatorZen", { fg = bg("Normal") })
end)
