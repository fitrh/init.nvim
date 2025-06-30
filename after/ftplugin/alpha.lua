vim.o.showtabline = 0

local augroup = vim.api.nvim_create_augroup("after/ftplugin/alpha", {})
vim.api.nvim_create_autocmd("BufUnload", {
  group = augroup,
  callback = function()
    vim.o.showtabline = 2
  end,
})
