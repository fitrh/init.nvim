local M = {}

local title = { "%t", color = { gui = "BOLD" } }

local location = {
  function()
    return ("[%%%sl/%%L]"):format(#tostring(vim.api.nvim_buf_line_count(0)))
  end,
  padding = 0,
}

M.filetypes = { "help" }

M.sections = { lualine_c = { "%=", title, location } }

M.inactive_sections = { lualine_c = { "%=%t" } }

return M
