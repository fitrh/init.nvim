---@param name string highlight group
---@param attr "fg"|"bg"|"sp"
---@return string|nil #RRGGBB
local function get(name, attr)
  local def = vim.api.nvim_get_hl(0, { name = name, link = false })
  if not def then
    return nil
  end

  if not attr then
    return def
  end

  local val = def[attr]
  if not val then
    return nil
  end

  return string.format("#%06X", val)
end

local a = vim.api
local augroup = a.nvim_create_augroup("quiet_override", {})
local function au(e, pat, fn)
  a.nvim_create_autocmd(e, {
    group = augroup,
    pattern = pat or "*",
    callback = function(args)
      fn(args)
      a.nvim_create_autocmd("OptionSet", {
        -- group = augroup,
        pattern = "background",
        callback = function()
          if vim.g.colors_name and vim.g.colors_name ~= "quiet" then
            return true
          end
          fn()
        end,
      })
    end,
    once = true,
  })
end

local palette = {}
palette.dark = {
  c0 = "#000000", -- 16 black
  c1 = "#d7005f", -- 161 darkred
  c2 = "#00af5f", -- 35 darkgreen
  c3 = "#d78700", -- 172 darkyellow
  c4 = "#0087d7", -- 32 darkblue
  c5 = "#d787d7", -- 176 darkmagenta
  c6 = "#00afaf", -- 37 darkcyan
  c7 = "#dadada", -- 253 grey
  c8 = "#707070", -- 242 darkgrey
  c9 = "#ff005f", -- 197 red
  c10 = "#00d75f", -- 41 green
  c11 = "#ffaf00", -- 214 yellow
  c12 = "#5fafff", -- 75 blue
  c13 = "#ff87ff", -- 213 magenta
  c14 = "#00d7d7", -- 44 cyan
  c15 = "#ffffff", -- 231 white
  diffred = "#d75f5f", -- 167 darkred
  diffgreen = "#00af00", -- 34 darkgreen
  diffblue = "#87afd7", -- 110 darkblue
  diffpink = "#d787d7", -- 176 darkmagenta
  uipink = "#ff00af", -- 199 magenta
  uilime = "#afff00", -- 154 green
  uiteal = "#00ffaf", -- 49 green
  uiblue = "#00afff", -- 39 blue
  uipurple = "#af00ff", -- 129 darkmagenta
  uiamber = "#ffaf00", -- 214 darkyellow
  uiblack = "#303030", -- 236 darkgrey
  yasogrey = "#1c1c1c", -- 234 black
  invisigrey = "#a8a8a8", -- 248 darkgrey
  linenrblack = "#585858", -- 240 darkgrey
  uicursearch = "#ff5fff", -- 207 magenta
  errorred = "#ff005f", -- 197 red
}
palette.light = {
  c0 = "#000000", -- 16 black
  c1 = "#af0000", -- 124 darkred
  c2 = "#005f00", -- 22 darkgreen
  c3 = "#af5f00", -- 130 darkyellow
  c4 = "#005faf", -- 25 darkblue
  c5 = "#870087", -- 90 darkmagenta
  c6 = "#008787", -- 30 darkcyan
  c7 = "#d7d7d7", -- 188 grey
  c8 = "#626262", -- 241 darkgrey
  c9 = "#d70000", -- 160 red
  c10 = "#008700", -- 28 green
  c11 = "#d78700", -- 172 yellow
  c12 = "#0087d7", -- 32 blue
  c13 = "#af00af", -- 127 magenta
  c14 = "#00afaf", -- 37 cyan
  c15 = "#ffffff", -- 231 white
  diffred = "#d78787", -- 174 red
  diffgreen = "#87d787", -- 114 green
  diffblue = "#afafd7", -- 146 blue
  diffpink = "#d787d7", -- 176 magenta
  uipink = "#ff00af", -- 199 magenta
  uilime = "#afff00", -- 154 green
  uiteal = "#00ffaf", -- 49 cyan
  uiblue = "#00afff", -- 39 blue
  uipurple = "#af00ff", -- 129 darkmagenta
  uiamber = "#ffaf00", -- 214 yellow
  brightwhite = "#eeeeee", -- 255 grey
  yasogrey = "#e4e4e4", -- 254 grey
  invisigrey = "#a8a8a8", -- 248 darkgrey
  linenrblack = "#585858", -- 240 darkgrey
  uicursearch = "#ff5fff", -- 207 magenta
  errorred = "#ff005f", -- 197 red
}

local background = vim.api.nvim_get_option_value("background", {})
local light = background == "light"
local c = palette[background]
local stlbg = c.yasogrey
local g = {}
-- syntax
g.Boolean = { fg = c.c5 }
g.Comment = { fg = c.c8, italic = true }
g.Function = { bold = true }
g.Keyword = { fg = light and "#585858" or c.invisigrey }
g.Number = { fg = c.c3 }
g.Statement = { fg = light and "#585858" or c.invisigrey } -- { fg = c.c4 }
g.String = { fg = c.c6 } -- { fg = c.c2 }
g.Type = { bold = true }

-- :h highlight-default
g.CursorLineNr = { bold = true }
g.ColorColumn = { bg = c[light and "brightwhite" or "uiblack"] }
g.Directory = { fg = c.c12 }
g.FloatBorder = { bg = stlbg }
-- g.Folded = { bg = c.yasogrey }
g.NormalFloat = { fg = c[light and "c0" or "c7"], bg = stlbg }
g.PmenuSel = { bg = get(light and "CursorLine" or "PmenuSel", "bg") }
g.StatusLine = { fg = c[light and "c8" or "invisigrey"], bg = stlbg }
g.StatusLineNC = { fg = get("LineNr", "fg"), bg = stlbg }
g.TabLineFill = { link = "StatusLineNC" }
if a.nvim_get_option_value("laststatus", {}) == 3 then
  g.WinSeparator = { fg = stlbg }
else
  g.WinSeparator = { fg = stlbg, bg = stlbg }
end

-- tree-sitter
g["@keyword.import"] = { fg = c.invisigrey }
g["@keyword.operator"] = {
  fg = c[light and "linenrblack" or "invisigrey"],
  bold = true,
}
g["@keyword.return"] = { bold = true }
g["@punctuation.special"] = { fg = c.invisigrey }
-- g["@tag"] = { fg = c.c3 }
g["@tag"] = { link = "@keyword" }
g["@tag.delimiter"] = { link = "LineNr" }
g["@tag.attribute"] = { fg = c.invisigrey, bold = true }
g["@diff.plus"] = { fg = c.diffgreen }
g["@diff.minus"] = { fg = c.diffred }
g["@markup.link"] = { fg = c.c4 }
g["@markup.heading"] = { bold = true }

g.diffAdded = { fg = c.diffgreen }
g.diffChanged = { fg = c.diffblue }
g.diffRemoved = { fg = c.diffred }

g.manReference = { link = "Number" }
g.manBold = { bold = true }

-- diagnostic
local hi_diagnostic = function()
  local hi = vim.api.nvim_set_hl
  for _, v in ipairs({ "Hint", "Info", "Warn", "Error" }) do
    local sp = get("Diagnostic" .. v, "fg")
    hi(0, "DiagnosticUnderline" .. v, { sp = sp, undercurl = true })
    local stl = "StatusLineDiagnostic" .. v
    hi(0, stl .. "Sign", { fg = sp, bg = stlbg })
    hi(0, stl .. "Count", { fg = sp, bg = stlbg, bold = true })
  end
  hi(0, "DiagnosticDeprecated", { undercurl = true })
end
au("DiagnosticChanged", "*", hi_diagnostic)

-- LSP
local hi_lsp_semantic = function()
  -- if not args.data then
  --   return
  -- end

  local hi = vim.api.nvim_set_hl
  -- local client = vim.lsp.get_client_by_id(args.data.client_id)

  -- if client.server_capabilities.codeLensProvider then
  hi(0, "LspCodeLens", { link = "LineNr" })
  hi(0, "LspCodeLensSeparator", { link = "NonText" })
  -- end
  -- if client.server_capabilities.documentHighlightProvider then
  local lsp_reference = {
    bg = c[light and "brightwhite" or "uiblack"],
    bold = true,
  }
  hi(0, "LspReferenceText", lsp_reference)
  hi(0, "LspReferenceRead", lsp_reference)
  hi(0, "LspReferenceWrite", lsp_reference)
  -- end
  -- if client.server_capabilities.semanticTokensProvider then
  hi(0, "@lsp.type.string", { link = "String" })
  hi(0, "@lsp.type.function", { link = "Function" })
  -- end

  -- if client.server_capabilities.signatureHelpProvider then
  hi(0, "LspSignatureActiveParameter", { fg = "fg", bg = "bg", reverse = true })
  -- end
end
au("LspTokenUpdate", "*", hi_lsp_semantic)
-- au("User", "QuietReload", hi_lsp_semantic)

-- plugin
--- cmp
local hi_cmp = function()
  local hi = vim.api.nvim_set_hl
  hi(0, "CmpCursorLine", { link = "PmenuSel" })
  hi(0, "CmpDoc", { link = "NormalFloat" })
  hi(0, "CmpItemAbbrMatch", { fg = c.c0, bold = true })
  hi(0, "CmpItemAbbrMatchFuzzy", { fg = c.c1 })
  hi(0, "CmpItemKind", { fg = get("LineNr", "fg") })
  hi(0, "CmpItemKindFolder", { fg = get("Directory", "fg") })
end
au("User", "CmpReady", hi_cmp)
--- gitsigns
-- local hi_gitsigns = function()
--   local hi = vim.api.nvim_set_hl
--   for _, k in ipairs({ "Add", "Change", "Delete" }) do
--     local fg = get("Diff" .. k, "fg")
--     hi(0, "GitSigns" .. k, { fg = fg })
--     hi(0, "StatusLineGitDiff" .. k, { fg = fg, bg = stlbg })
--   end
-- end
-- au("User", "GitSignsUpdate", hi_gitsigns)
local hi = vim.api.nvim_set_hl
for _, k in ipairs({ "Add", "Change", "Delete" }) do
  local fg = get("Diff" .. k, "fg")
  hi(0, "GitSigns" .. k, { fg = fg })
  hi(0, "StatusLineGitDiff" .. k, { fg = fg, bg = stlbg })
end
--- incline
g.InclineNormal = { link = "StatusLine" }
g.InclineNormalNC = { link = "StatusLineNC" }
g.InclineSep = { fg = get("LineNr", "fg") }
g.InclineTail = { fg = get("LineNr", "fg"), bold = true }
g.InclineWinNr = { fg = c.c3 }
--- modes
g.ModesCopy = { bg = c.c11 }
g.ModesCopyCursorLineNr = { fg = c.c11 }
g.ModesDelete = { bg = c.c9 }
g.ModesDeleteCursorLineNr = { fg = c.c9 }
g.ModesInsert = { bg = c.c10 }
g.ModesInsertCursorLineNr = { fg = c.c10 }
g.ModesVisual = { bg = c.c13 }
g.ModesVisualCursorLineNr = { fg = c.c13 }
--- statusline
g.StatusLineDim = { fg = get("LineNr", "fg"), bg = stlbg }
g.StatusLineFilename = {
  fg = c[light and "c8" or "invisigrey"],
  bg = stlbg,
  bold = true,
}
g.StatusLineModified = { fg = get("DiffChange", "fg"), bg = stlbg }
g.StatusLineRO = { fg = get("DiagnosticError", "fg"), bg = stlbg }
g.StatusLineWinNr = { fg = g.Number.fg, bg = stlbg }
--- tabline
g.TabLineModified = { link = "TabLine" }
g.TabLineSep = { link = "TabLine" }
g.TabLineModifiedSel = { link = "TabLineSel" }
g.TabLineSepSel = { link = "TabLineSel" }
--- telescope
g.TelescopeNormal = { fg = c[light and "c8" or "c7"], bg = c.yasogrey }
g.TelescopeBorder = { fg = c.yasogrey, bg = c.yasogrey }
-- g.TelescopeSelection = { bg = c[light and "c7" or "c8"] }
g.TelescopeSelection = { link = "CursorLine" }
g.TelescopeTitle = { fg = c[light and "c0" or "uiblack"], bg = c.c7 }
g.TelescopeMatching = { fg = c.c11, bold = true }

local set = vim.api.nvim_set_hl
for name, val in pairs(g) do
  set(0, name, val)
end
local Number = vim.api.nvim_get_hl(0, { name = "Number" })
vim.api.nvim_set_hl(0, "ModeMsg", { fg = Number.fg })
