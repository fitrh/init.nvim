---@param name string highlight group
---@param attr "fg"|"bg"|"sp"
---@return string|nil #RRGGBB
local function get(name, attr)
  local val = vim.api.nvim_get_hl(0, { name = name, link = false })[attr]
  if not val then
    return nil
  end

  return string.format("#%06X", val)
end

local a = vim.api
local augroup = a.nvim_create_augroup("adwaita_override", {})
local function au(e, pat, fn)
  a.nvim_create_autocmd(e, {
    group = augroup,
    pattern = pat or "*",
    callback = fn,
    once = true,
  })
end

local g = {}
g.CursorLineNr = { fg = get("CursorLineNr", "fg") }
g.Directory = { link = "Function" }
for _, v in ipairs({ "Hint", "Info", "Warn", "Error" }) do
  local sp = get("Diagnostic" .. v, "fg")
  g["DiagnosticUnderline" .. v] = { sp = sp, undercurl = true }
end
g.PmenuSel = { bg = get("PmenuSel", "bg") }
local stlbg = get("StatusLine", "bg")
g.StatusLine = { fg = get("CursorLineNr", "fg"), bg = stlbg }
g.TabLine = { link = "StatusLine" }
g.TabLineFill = { link = "TabLine" }
g.TabLineSel = { link = "Normal" }
g.StatusLineNr = { fg = get("LineNr", "fg"), bg = stlbg }
g.LineNr = { fg = get("LineNr", "fg") }
g.LspCodeLens = { link = "LineNr" }
g.LspCodeLensSeparator = { link = "NonText" }
g.LspSignatureActiveParameter = { link = "PmenuSel" }
-- tree-sitter
g["@text.diff.add"] = { fg = get("DiffAdd", "fg") }
g["@text.diff.delete"] = { fg = get("DiffDelete", "fg") }

-- plugin
--- cmp
g.CmpCursorLine = { link = "PmenuSel" }
g.CmpDoc = { link = "PmenuSbar" }
--- gitsigns
au("User", "GitSignsUpdate", function()
  local hi = vim.api.nvim_set_hl
  for _, k in ipairs({ "Add", "Change", "Delete" }) do
    local fg = get("Diff" .. k, "fg")
    hi(0, "GitSigns" .. k, { fg = fg })
    hi(0, "StatusLineGitDiff" .. k, { fg = fg, bg = stlbg })
  end
end)
--- incline
g.InclineWinNr = { fg = get("Number", "fg") }
--- statusline
g.StatusLineDim = { fg = get("LineNr", "fg"), bg = stlbg }
g.StatusLineFilename = { fg = get("StatusLine", "fg"), bg = stlbg, bold = true }
g.StatusLineModified = { fg = get("DiffChange", "fg"), bg = stlbg }
g.StatusLineRO = { fg = get("DiagnosticError", "fg"), bg = stlbg }
--- tabline
g.TabLineModified = { link = "TabLine" }
g.TabLineSep = { link = "TabLine" }
g.TabLineModifiedSel = { link = "TabLineSel" }
g.TabLineSepSel = { link = "TabLineSel" }
--- telescope
local pmenu_bg = get("Pmenu", "bg")
g.TelescopeBorder = { fg = pmenu_bg, bg = pmenu_bg }
g.TelescopePromptBorder = { link = "TelescopeBorder" }
g.TelescopePromptCounter = { fg = get("LineNr", "fg") }
g.TelescopeResultsBorder = { link = "TelescopeBorder" }
g.TelescopePreviewBorder = { link = "TelescopeBorder" }
g.TelescopeNormal = { link = "Pmenu" }
g.TelescopeTitle = { link = "StatusLine" }
g.TelescopeSelection = { link = "PmenuSel" }

local set = vim.api.nvim_set_hl
for name, val in pairs(g) do
  set(0, name, val)
end
