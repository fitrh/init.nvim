local title = {
  function()
    return " Telescope"
  end,
  color = { gui = "BOLD" },
}

local M = {}

M.filetypes = { "TelescopePrompt" }

M.sections = { lualine_c = { "%=", title } }

return M
