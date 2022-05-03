vim.g.material_style = "deep ocean" -- deep ocean, oceanic, palenight, darker

require("material").setup({
  contrast = {
    sidebar = true,
  },
  italics = {
    comments = true,
    keywords = true,
  },
  async_loading = false,
})

vim.cmd([[colorscheme material]])

local c = require("material.colors")
local hi = require("sugar.highlight")

hi.set("StatusLine", { fg = c.text, bg = c.bg_alt })

hi.colorscheme({
  -- highlight-default
  { "ColorColumn", link = "StatusLine" },
  { "CursorLine", bg = c.highlight },
  { "TabLine", link = "StatusLine" },
  { "TablineFill", link = "TabLine" },
  { "TabLineSel", inherit = "Normal", fg = c.accent },
  { "VertSplit", fg = hi.bg("StatusLine"), cterm = { reverse = true } },
  { "WinSeparator", link = "VertSplit" },

  -- lsp-highlight
  { "LspSignatureActiveParameter", fg = c.accent },

  -- plugin
  { "InclineNormal", link = "StatusLine" },
  { "InclineNormalNC", inherit = "StatusLine", fg = hi.fg("NonText") },
  { "ModesCopy", bg = c.darkyellow },
  { "ModesDelete", bg = c.red },
  { "ModesInsert", bg = c.darkgreen },
  { "ModesVisual", bg = c.purple },
  { "NotifyTRACEBorder", link = "DiagnosticHint" },
  { "NotifyTRACETitle", link = "NotifyTRACEBorder" },
  { "NotifyTRACEIcon", link = "NotifyTRACEBorder" },
  { "NotifyDEBUGBorder", fg = c.paleblue },
  { "NotifyDEBUGTitle", link = "NotifyDEBUGBorder" },
  { "NotifyDEBUGIcon", link = "NotifyDEBUGBorder" },
  { "NotifyINFOBorder", link = "DiagnosticInfo" },
  { "NotifyINFOTitle", link = "NotifyINFOBorder" },
  { "NotifyINFOIcon", link = "NotifyINFOBorder" },
  { "NotifyWARNBorder", link = "DiagnosticWarn" },
  { "NotifyWARNTitle", link = "NotifyWARNBorder" },
  { "NotifyWARNIcon", link = "NotifyWARNBorder" },
  { "NotifyERRORBorder", link = "DiagnosticError" },
  { "NotifyERRORTitle", link = "NotifyERRORBorder" },
  { "NotifyERRORIcon", link = "NotifyERRORBorder" },
  { "StatusLineGitBranch", inherit = "StatusLine", fg = c.purple },
  { "StatusLineModified", inherit = "StatusLine", fg = c.red },
  { "StatusLineRO", inherit = "StatusLine", fg = c.darkred },
  { "StatusLineMNormal", fg = c.accent },
  { "StatusLineMInsert", fg = c.green },
  { "StatusLineMVisual", fg = c.purple },
  { "StatusLineMReplace", fg = c.red },
  { "StatusLineMCommand", fg = c.yellow },
  { "TreesitterContext", link = "LspReferenceText" },
})
