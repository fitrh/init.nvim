local M = {}

M.mk = function()
  local fn = vim.fn
  local dir = fn.expand("%:p:h")

  if fn.isdirectory(dir) == 0 then
    fn.mkdir(dir, "p")
  end
end

return M
