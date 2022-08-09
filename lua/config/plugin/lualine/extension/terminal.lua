local M = {}

local title = {
  function()
    local str = vim.split(vim.b.term_title, "//")
    return (" %s"):format(#str > 1 and str[#str] or "%t")
  end,
  color = { gui = "BOLD" },
}

M.filetypes = { "terminal" }

M.sections = { lualine_c = { "%=", title } }

M.inactive_sections = {}

return M
