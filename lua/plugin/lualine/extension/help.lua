local M = {}

local component = {
  function()
    return ("ﬤ %s"):format(vim.fn.expand("%:t"))
  end,
  color = { gui = "BOLD" },
}

M.filetypes = { "help" }

M.sections = { lualine_c = { "%=", component } }

M.inactive_sections = {}

return M
