local M = {}

function M.zen(args)
  local opts = args or {}
  local opt = vim.opt
  local signcolumn = opt.signcolumn
  local number = opt.number
  local relativenumber = opt.relativenumber
  local laststatus = opt.laststatus

  if (signcolumn:get() == "yes") then
    signcolumn = "no"
    number = false
    relativenumber = false
    if opts.laststatus then laststatus = 0 end
  else
    signcolumn = "yes"
    number = true
    relativenumber = true
    if opts.laststatus then vim.opt.laststatus = 2 end
  end
end

return M
