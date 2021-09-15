local M = {}

function M.toggle(args)
  local opts = args or {}
  local opt = vim.opt

  if opt.signcolumn:get() == "yes" then
    opt.signcolumn = "no"
    opt.number = false
    opt.relativenumber = false
    if opts.laststatus then
      opt.laststatus = 0
    end
  else
    opt.signcolumn = "yes"
    opt.number = true
    opt.relativenumber = true
    if opts.laststatus then
      vim.opt.laststatus = 2
    end
  end
end

return M
