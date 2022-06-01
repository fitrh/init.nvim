local M = {}

local state = {
  laststatus = vim.api.nvim_get_option("laststatus"),
}

function M.toggle(args)
  local opts = args or {}

  if vim.api.nvim_win_get_option(0, "signcolumn") == "yes" then
    vim.api.nvim_win_set_option(0, "signcolumn", "no")
    vim.api.nvim_win_set_option(0, "number", false)
    vim.api.nvim_win_set_option(0, "relativenumber", false)
    if opts.laststatus then
      vim.api.nvim_set_option("laststatus", 0)
    end
  else
    vim.api.nvim_win_set_option(0, "signcolumn", "yes")
    vim.api.nvim_win_set_option(0, "number", true)
    vim.api.nvim_win_set_option(0, "relativenumber", true)
    if opts.laststatus then
      vim.api.nvim_set_option("laststatus", state.laststatus)
    end
  end
end

return M
