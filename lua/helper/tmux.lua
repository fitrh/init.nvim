local M = {}

local api = vim.api
local directions = {
  h = "L",
  j = "D",
  k = "U",
  l = "R",
}

function M.move(direction)
  local current_win = api.nvim_get_current_win()

  vim.cmd(("wincmd %s"):format(direction))

  if api.nvim_get_current_win() == current_win then
    vim.fn.system(("tmux selectp -%s"):format(directions[direction]))
  end
end

return M
