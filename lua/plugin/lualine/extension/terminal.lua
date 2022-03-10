local M = {}

local component = {
  function()
    return " %t"
  end,
  color = { gui = "BOLD" },
}

M.filetypes = { "terminal" }

M.sections = { lualine_c = { "%=", component } }

M.inactive_sections = {}

return M
