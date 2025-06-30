---Get `NVIM_` env variable
---@param env string
---@return string?
local function nenv(env)
  return os.getenv("NVIM_" .. env)
end

local function get_mode()
  local modes = { dark = "dark", light = "light" }
  return modes[nenv("OXOCARBON_MODE") or nenv("BACKGROUND")]
end

local mode = get_mode()
if mode then
  vim.api.nvim_set_option_value("background", mode, {})
end
vim.cmd.colorscheme("oxocarbon")

local palette = {
  dark = {
    ["00"] = "#161616",
    ["01"] = "#262626",
    ["02"] = "#393939",
    ["03"] = "#525252",
    ["04"] = "#dde1e6",
    ["05"] = "#f2f2f2",
    ["06"] = "#ffffff",
    ["07"] = "#08bdba",
    ["08"] = "#3ddbd9",
    ["09"] = "#78a9ff",
    ["0A"] = "#ee5396",
    ["0B"] = "#33b1ff",
    ["0C"] = "#ff7eb6",
    ["0D"] = "#42be65",
    ["0E"] = "#be95ff",
    ["0F"] = "#82cfff",
    ["10"] = "#131313",
  },
  light = {
    ["00"] = "#ffffff",
    ["01"] = "#f2f2f2",
    ["02"] = "#d0d0d0",
    ["03"] = "#161616",
    ["04"] = "#37474f",
    ["05"] = "#90a4ae",
    ["06"] = "#525252",
    ["07"] = "#08bdba",
    ["08"] = "#ff7eb6",
    ["09"] = "#ee5396",
    ["0A"] = "#ff6f00",
    ["0B"] = "#0f62fe",
    ["0C"] = "#673ab7",
    ["0D"] = "#42be65",
    ["0E"] = "#be95ff",
    ["0F"] = "#ffab91",
    ["10"] = "#fafafa",
  },
}

require("sugar.highlight").colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend
  local a = vim.api
  local background = a.nvim_get_option_value("background", {})
  local p = palette[background]
  local base = p["00"]
  local normal = { fg = p["04"], bg = p["00"] }
  local normal_fg = { fg = p["04"] }

  local concat = table.concat
  local augroup = a.nvim_create_augroup("oxocarbon", {})
  local function au(e, pat, fn)
    a.nvim_create_autocmd(e, {
      group = augroup,
      pattern = pat or "*",
      callback = fn,
      once = true,
    })
  end

  local is_light = background == "light"
  local function lightdark(light, dark)
    return is_light and light or dark
  end

  -- :h highlight-default
  set("Cursor", normal_fg)
  set("CursorLineNr", normal_fg)
  set("Error", normal_fg)
  set("FloatTitle", { fg = p["03"], bold = true })
  link("FoldColumn", "LineNr")
  set("Folded", { fg = p["03"], bg = p["01"] })
  set("LineNr", { fg = p["03"] })
  set("ModeMsg", normal_fg)
  link("MsgArea", "StatusLine")
  set("Normal", normal)
  set("Pmenu", { fg = normal.fg, bg = p["01"] })
  set("PmenuSbar", { fg = p["04"], bg = p["01"] })
  set("Question", normal_fg)
  link("SignColumn", "LineNr")
  set("StatusLine", {
    fg = blend(p["04"], p["10"], lightdark(1, 0.5)),
    bg = p["10"],
  })
  set("StatusLineNC", { inherit = "StatusLine", fg = p["03"] })
  set("Substitute", { bg = blend(p["08"], base, lightdark(0.3, 0.15)) })
  link("TabLine", "StatusLineNC")
  link("TabLineFill", "TabLine")
  link("TabLineSel", "Normal")
  set("TermCursor", { fg = base, bg = p["04"] })
  set("TermCursorNC", { fg = base, bg = p["04"] })
  set("Title", normal_fg)
  set("VertSplit", { fg = p["02"] })

  -- :h group-name
  set("Constant", normal_fg)
  set("Identifier", normal_fg)
  set("Special", normal_fg)
  set("SpecialChar", normal_fg)
  set("Tag", normal_fg)

  -- :h diagnostic-highlights
  au("DiagnosticChanged", "*", function()
    set("DiagnosticHint", { fg = p["0F"] })
    set("DiagnosticUnnecessary", { fg = p["03"] })
    for _, v in ipairs({ "Info", "Hint", "Warn", "Error" }) do
      local group = concat({ "DiagnosticUnderline", v })
      set(group, { sp = fg(concat({ "Diagnostic", v })), undercurl = true })
    end
  end)

  -- :h treesitter-highlight-groups
  link("@constant", "Constant")
  set("@field", normal_fg)
  set("@module", normal_fg)
  set("@tag", normal_fg)
  set("@markup", normal_fg)
  link("@diff.plus", "diffAdded")
  link("@diff.minus", "diffRemoved")
  set("@markup.raw", normal_fg)
  set("@markup.raw.markdown_inline", { fg = p["0F"] })
  set("@markup.link", { fg = p["0E"] })
  set("@markup.list.checked", { fg = p["03"] })
  set("@markup.list.unchecked", { fg = p["0C"], bold = true })
  set("@type.builtin", normal_fg)
  set("@variable", normal_fg)
  set("@variable.builtin", normal_fg)
  set("@variable.parameter", normal_fg)

  -- :h lsp-highlight
  au({ "LspAttach", "LspTokenUpdate" }, "*", function()
    if is_light then
      set("LspReferenceText", { bg = p["02"] })
      set("LspReferenceRead", { bg = p["02"] })
      set("LspReferenceWrite", { bg = p["02"] })
    end
  end)

  -- :h lsp-semantic-highlight
  -- au("LspTokenUpdate", "*", function()
  --   link("@lsp.type.function", "@function")
  --   set("@lsp.type.property", { fg = p["0F"] })
  --   set("@lsp.typemod.variable.defaultLibrary", { fg = p["0C"] })
  -- end)

  -- plugin

  --- cmp
  au("User", "CmpReady", function()
    set("CmpCursorLine", { bg = bg("PmenuSel") })
    set("CmpDoc", { bg = bg("PmenuSel"), blend = 0 })
    set("CmpItemAbbrMatchFuzzy", normal_fg)
    set("CmpItemMenu", normal_fg)
    for _, kind in ipairs({
      "Interface",
      "Color",
      "TypeParameter",
      "Text",
      "Enum",
      "Keyword",
      "Constant",
      "Constructor",
      "Reference",
      "Function",
      "Struct",
      "Class",
      "Module",
      "Operator",
      "Field",
      "Property",
      "Event",
      "Unit",
      "Snippet",
      "Folder",
      "Variable",
      "File",
      "Method",
      "Value",
      "EnumMember",
    }) do
      local group = concat({ "CmpItemKind", kind })
      set(group, { fg = bg(group) })
    end
  end)

  --- gitsigns
  set("GitSignsAdd", { fg = fg("DiffAdded") })
  set("GitSignsChange", { fg = fg("DiffChanged") })
  set("GitSignsCurrentLineBlame", { fg = p["03"] })
  set("GitSignsDelete", { fg = fg("DiffRemoved") })

  --- incline
  link("InclineNormal", "StatusLine")
  link("InclineNormalNC", "StatusLineNC")
  set("InclineSep", { fg = p["02"], bold = true })
  set("InclineTail", { fg = p["03"], bold = true })
  set("InclineWinNr", { fg = p["0A"], bg = blend(p["0A"], p["10"], 0.1) })

  --- litee
  au("LspRequest", "*", function()
    set("LTSymbol", { fg = p["0F"] })
    link("LTSymbolDetail", "Comment")
    link("LTSymbolJump", "LspReferenceText")
    link("LTBoolean", "@boolean")
    link("LTConstant", "@constant")
    link("LTConstructor", "@constructor")
    link("LTField", "@field")
    link("LTFunction", "@function")
    link("LTMethod", "@method")
    link("LTNamespace", "@namespace")
    link("LTNumber", "@number")
    link("LTOperator", "@operator")
    link("LTParameter", "@parameter")
    link("LTParameterReference", "@parameter.reference")
    link("LTString", "@string")
    link("LTType", "@type")
    link("LTURI", "@text.uri")
  end)

  --- modes
  set("ModesCopy", { bg = bg("IncSearch") })
  set("ModesDelete", { bg = p["08"] })
  set("ModesInsert", { bg = p["0C"] })
  set("ModesVisual", { bg = p["0E"] })
  for _, v in ipairs({ "Copy", "Delete", "Insert", "Visual" }) do
    local group = concat({ "Modes", v, "CursorLineNr" })
    set(group, { fg = bg(concat({ "Modes", v })) })
  end

  --- github.com/rcarriga/nvim-notify
  for _, v in ipairs({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }) do
    local title = concat({ "Notify", v, "Title" })
    local color = blend(fg(title), normal.bg, lightdark(0.2, 0.05))
    set(concat({ "Notify", v, "Border" }), { fg = color, bg = color })
    set(concat({ "Notify", v, "Body" }), { inherit = title, bg = color })
    link(concat({ "Notify", v, "Icon" }), title)
  end

  --- statusline
  link("StatusLineDim", "StatusLineNC")
  set("StatusLineFilename", { inherit = "StatusLine", bold = true })
  set("StatusLineGitBranch", { inherit = "StatusLine", fg = p["0E"] })

  for _, kind in ipairs({ "Add", "Change", "Delete" }) do
    local group = concat({ "StatusLineGitDiff", kind })
    local gitsigns = concat({ "GitSigns", kind })
    set(group, { inherit = "StatusLine", fg = fg(gitsigns) })
  end

  au("DiagnosticChanged", "*", function()
    for _, severity in ipairs({ "Error", "Warn", "Info", "Hint" }) do
      local count = concat({ "StatusLineDiagnostic", severity, "Count" })
      local sign = concat({ "StatusLineDiagnostic", severity, "Sign" })
      local sign_hl = concat({ "Diagnostic", "Sign", severity })
      local sign_fg = blend(fg(sign_hl), bg("StatusLine"), 0.7)
      set(count, { inherit = "StatusLine", fg = fg(sign_hl) })
      set(sign, { inherit = "StatusLine", fg = sign_fg })
    end
  end)

  set("StatusLineModified", { inherit = "StatusLine", fg = p["0C"] })
  set("StatusLinePath", {
    inherit = "StatusLineNC",
    fg = p[lightdark("05", "02")],
  })
  set("StatusLinePathSep", { inherit = "StatusLineDim", bold = true })
  set("StatusLineRO", { inherit = "StatusLine", fg = p["0A"] })

  --- tabline
  set("TabLineModified", { inherit = "TabLine", fg = p["0C"] })
  link("TabLineSep", "TabLine")
  set("TabLineModifiedSel", { inherit = "TabLineSel", fg = p["0C"] })
  set("TabLineSepSel", { inherit = "TabLineSel", fg = p["07"] })

  --- telescope
  if is_light then
    set("TelescopeNormal", { fg = p["04"], bg = p["10"] })
  end
  set("TelescopePromptNormal", { fg = p[lightdark("04", "05")], bg = p["10"] })
  set("TelescopePromptBorder", { fg = p["10"], bg = p["10"] })
  set("TelescopePromptPrefix", {
    inherit = "TelescopePromptPrefix",
    bg = p["10"],
  })

  --- zen
  set("WinSeparatorZen", { fg = base })
end)
