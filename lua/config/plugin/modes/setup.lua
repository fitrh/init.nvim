local config = {}

config.line_opacity = { insert = 0, visual = 0.2 }
config.set_cursorline = false

require("modes").setup(config)

for _, mode in ipairs({ "Insert", "Copy", "Visual", "Delete" }) do
  local linenr = string.format("Modes%sCursorLineNr", mode)

  for _, kind in ipairs({ "Fold", "Sign" }) do
    local group = string.format("Modes%sCursorLine%s", mode, kind)
    vim.api.nvim_set_hl(0, group, { link = linenr })
  end
end
