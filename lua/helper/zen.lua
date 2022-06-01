local M = {}

local state = {
  zen = false,
  laststatus = vim.api.nvim_get_option("laststatus"),
  colorcolumn = vim.api.nvim_win_get_option(0, "colorcolumn"),
  showtabline = vim.api.nvim_get_option("showtabline"),
  signcolumn = vim.api.nvim_win_get_option(0, "signcolumn"),
}

function M.toggle(args)
  local opts = args or {}

  if not state.zen then
    vim.api.nvim_set_option("showtabline", 0)
    vim.api.nvim_win_set_option(0, "colorcolumn", "")
    vim.api.nvim_win_set_option(0, "signcolumn", "no")
    vim.api.nvim_win_set_option(0, "number", false)
    vim.api.nvim_win_set_option(0, "relativenumber", false)
    if opts.laststatus then
      vim.api.nvim_set_option("laststatus", 0)
    end
  else
    vim.api.nvim_set_option("showtabline", state.showtabline)
    vim.api.nvim_win_set_option(0, "colorcolumn", state.colorcolumn)
    vim.api.nvim_win_set_option(0, "signcolumn", state.signcolumn)
    vim.api.nvim_win_set_option(0, "number", true)
    vim.api.nvim_win_set_option(0, "relativenumber", true)
    if opts.laststatus then
      vim.api.nvim_set_option("laststatus", state.laststatus)
    end
  end

  state.zen = not state.zen
end

return M
