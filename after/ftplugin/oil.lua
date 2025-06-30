vim.wo.statusline = " %f "

vim.schedule(function()
  if not package.loaded["oil-git-status"] then
    vim.cmd.packadd("oil-git-status")
    require("oil-git-status").setup()
  end
end)
