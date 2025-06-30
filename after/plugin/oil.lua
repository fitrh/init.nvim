if not package.loaded["oil"] then
  vim.cmd.packadd("oil")
end

vim.schedule(function()
  require("config.plugin.oil.setup")
end)
