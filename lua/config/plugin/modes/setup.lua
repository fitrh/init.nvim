local config = {}

config.line_opacity = { insert = 0, visual = 0.2 }
config.set_cursorline = false

require("modes").setup(config)

local hi = vim.api.nvim_set_hl
for _, mode in ipairs({ "Insert", "Copy", "Visual", "Delete" }) do
  local linenr = string.format("Modes%sCursorLineNr", mode)

  -- hi(0, "Modes" .. mode .. "CursorLineNr", { link = "CursorLineNr" })
  -- hi(0, "Modes" .. mode .. "CursorLineSign", { link = "SignColumn" })
  -- hi(0, "Modes" .. mode .. "CursorLineFold", { link = "FoldColumn" })
  for _, kind in ipairs({ "Fold", "Sign" }) do
    local group = "Modes" .. mode .. "CursorLine" .. kind
    hi(0, group, { link = linenr })
  end
end
