local function get_mode()
  local modes = { dark = "dark", light = "light" }
  return modes[os.getenv("NVIM_GRUVBOX_MODE")] or "dark"
end

local function get_variant()
  local variants = { soft = "soft", hard = "hard" }
  return variants[os.getenv("NVIM_GRUVBOX_VARIANT")] or ""
end

local variant = get_variant()
if not os.getenv("NVIM_BACKGROUND") and os.getenv("NVIM_GRUVBOX_MODE") then
  vim.api.nvim_set_option_value("background", get_mode(), {})
end
local gruvbox = require("gruvbox")
gruvbox.setup({ contrast = variant })
gruvbox.load()

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local fmt = string.format
  local concat = table.concat

  local background = vim.api.nvim_get_option_value("background", {})
  local function lightdark(light, dark)
    return background == "light" and light or dark
  end

  -- TODO: adapt to https://github.com/ellisonleao/gruvbox.nvim/pull/280
  local palette = gruvbox.palette
  local p = {}
  if background == "dark" then
    p = {
      bg0 = palette.dark0,
      bg1 = palette.dark1,
      bg2 = palette.dark2,
      bg3 = palette.dark3,
      bg4 = palette.dark4,
      fg0 = palette.light0,
      fg1 = palette.light1,
      fg2 = palette.light2,
      fg3 = palette.light3,
      fg4 = palette.light4,
      red = palette.bright_red,
      green = palette.bright_green,
      yellow = palette.bright_yellow,
      blue = palette.bright_blue,
      purple = palette.bright_purple,
      aqua = palette.bright_aqua,
      orange = palette.bright_orange,
      neutral_red = palette.neutral_red,
      neutral_green = palette.neutral_green,
      neutral_yellow = palette.neutral_yellow,
      neutral_blue = palette.neutral_blue,
      neutral_purple = palette.neutral_purple,
      neutral_aqua = palette.neutral_aqua,
      dark_red = palette.dark_red,
      dark_green = palette.dark_green,
      dark_aqua = palette.dark_aqua,
      gray = palette.gray,
    }
  elseif background == "light" then
    p = {
      bg0 = palette.light0,
      bg1 = palette.light1,
      bg2 = palette.light2,
      bg3 = palette.light3,
      bg4 = palette.light4,
      fg0 = palette.dark0,
      fg1 = palette.dark1,
      fg2 = palette.dark2,
      fg3 = palette.dark3,
      fg4 = palette.dark4,
      red = palette.faded_red,
      green = palette.faded_green,
      yellow = palette.faded_yellow,
      blue = palette.faded_blue,
      purple = palette.faded_purple,
      aqua = palette.faded_aqua,
      orange = palette.faded_orange,
      neutral_red = palette.neutral_red,
      neutral_green = palette.neutral_green,
      neutral_yellow = palette.neutral_yellow,
      neutral_blue = palette.neutral_blue,
      neutral_purple = palette.neutral_purple,
      neutral_aqua = palette.neutral_aqua,
      dark_red = palette.light_red,
      dark_green = palette.light_green,
      dark_aqua = palette.light_aqua,
      gray = palette.gray,
    }
  end

  if variant ~= "" then
    p.bg0 = palette[background .. "0_" .. variant]
    p.dark_red = palette[background .. "_red_" .. variant]
    p.dark_green = palette[background .. "_green_" .. variant]
    p.dark_aqua = palette[background .. "_aqua_" .. variant]
  end
  local base = { fg = p.fg1, bg = p.bg0 }

  -- highlight-default
  set("ColorColumn", {
    bg = blend(bg("ColorColumn"), base.bg, lightdark(0.6, 0.3)),
  })
  set("CursorColumn", {
    bg = blend(bg("CursorLine"), base.bg, lightdark(0.6, 0.3)),
  })
  link("CursorLine", "CursorColumn")
  set("CursorLineNr", { fg = p.yellow })
  set("DiagnosticSignInfo", { inherit = "DiagnosticSignInfo", bg = "NONE" })
  set("DiagnosticSignWarn", { inherit = "DiagnosticSignWarn", bg = "NONE" })
  set("DiagnosticSignHint", { inherit = "DiagnosticSignHint", bg = "NONE" })
  set("DiagnosticSignError", { inherit = "DiagnosticSignError", bg = "NONE" })
  set("DiffAdd", { inherit = "DiffAdd", reverse = false })
  set("DiffChange", { inherit = "DiffChange", reverse = false })
  set("DiffDelete", { inherit = "DiffDelete", reverse = false })
  set("DiffText", { inherit = "DiffText", reverse = false })
  set("FloatBorder", { inherit = "NormalFloat", fg = bg("NormalFloat") })
  set("FoldColumn", { inherit = "FoldColumn", bg = "NONE" })
  set("Folded", { inherit = "Folded", bg = "NONE" })
  link("MsgArea", "StatusLine")
  link("SignColumn", "LineNr")
  set("StatusLine", { bg = p.bg1, fg = p.fg3 })
  set("TabLineSel", { inherit = "TabLineSel", bg = base.bg })
  set("VertSplit", { fg = p.bg1 })

  -- :h treesitter-highlight-groups
  set("@text.todo.checked", { fg = fg("Done") })
  set("@text.todo.unchecked", { fg = fg("Todo"), bold = true })

  -- :h lsp-semantic-highlight
  link("@lsp.typemod.function.defaultLibrary", "@function.builtin")

  -- health
  link("healthError", "DiagnosticError")
  set("healthSuccess", { fg = p.green })
  link("healthWarning", "DiagnosticWarn")

  -- plugin
  link("CmpCursorLine", "Visual")
  set("CmpDoc", { inherit = "PmenuThumb", blend = 0 })
  link("FloatTitle", "Title")
  set("GitSignsAdd", { inherit = "GitSignsAdd", bg = "NONE" })
  set("GitSignsChange", { inherit = "GitSignsChange", bg = "NONE" })
  set("GitSignsDelete", { inherit = "GitSignsDelete", bg = "NONE" })
  link("InclineNormal", "StatusLine")
  set("InclineNormalNC", { inherit = "StatusLine", fg = fg("Comment") })
  set("InclineSep", { fg = fg("Comment"), bold = true })
  set("InclineTail", { fg = p.fg4, bold = true })
  set("InclineWinNr", {
    fg = p.yellow,
    bg = blend(p.yellow, bg("StatusLine"), lightdark(0.2, 0.1)),
  })
  set("LspSignatureActiveParameter", { fg = p.yellow })
  set("ModesCopy", { bg = fg("IncSearch") })
  set("ModesCopyCursorLineNr", { fg = bg("ModesCopy") })
  set("ModesDelete", { bg = p.red })
  set("ModesDeleteCursorLineNr", { fg = bg("ModesDelete") })
  set("ModesInsert", { bg = p.blue })
  set("ModesInsertCursorLineNr", { fg = bg("ModesInsert") })
  set("ModesVisual", { bg = p.purple })
  set("ModesVisualCursorLineNr", { fg = bg("ModesVisual") })

  --- github.com/rcarriga/nvim-notify
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local title = fmt("Notify%sTitle", v)
    local color = blend(fg(title), base.bg, lightdark(0.1, 0.05))
    set(fmt("Notify%sBody", v), { inherit = title, bg = color })
    set(fmt("Notify%sBorder", v), { fg = color, bg = color })
    link(concat({ "Notify", v, "Icon" }), title)
  end

  set("StatusLineDim", { inherit = "StatusLine", fg = p.fg4 })
  for _, severity in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    local sign = concat({ "StatusLineDiagnostic", severity, "Sign" })
    local count = concat({ "StatusLineDiagnostic", severity, "Count" })
    local sign_hl = concat({ "Diagnostic", "Sign", severity })
    local severfg = fg(sign_hl)
    set(count, { inherit = "StatusLine", fg = severfg, bold = true })
    set(sign, { inherit = "StatusLine", fg = severfg })
  end
  set("StatusLineFilename", { inherit = "StatusLine", bold = true })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = p.purple })
  for _, kind in ipairs({ "Add", "Change", "Delete" }) do
    local group = ("StatusLineGitDiff%s"):format(kind)
    set(group, { inherit = "StatusLine", fg = fg(("GitSigns%s"):format(kind)) })
  end
  set("StatusLineModified", { inherit = "StatusLine", fg = palette.bright_red })
  set("StatusLinePath", { inherit = "StatusLine", fg = fg("Comment") })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = palette.faded_red })
  set("TabLineModified", { inherit = "TabLine", fg = palette.bright_red })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = palette.bright_red })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = p.blue })
  set("TelescopeNormal", { bg = bg("StatusLine") })
  link("TelescopePreviewLine", "CursorLine")
  set("TelescopeTitle", { inherit = "Visual", fg = base.fg, bold = true })
  set("TelescopeBorder", { bg = bg("StatusLine"), fg = bg("StatusLine") })
  link("TelescopePromptBorder", "TelescopeBorder")
  link("TelescopePromptCounter", "StatusLine")
  link("TelescopePreviewBorder", "TelescopeBorder")
  link("TelescopeResultsBorder", "TelescopeBorder")
  set("TreesitterContext", { inherit = "ColorColumn", bold = true })
  set("TreesitterContextLineNumber", {
    inherit = "TreesitterContext",
    fg = base.fg,
  })
  set("WinSeparatorZen", { fg = base.bg })
end)
